package com.minh.teashop.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Address;
import com.minh.teashop.domain.Cart;
import com.minh.teashop.domain.CartDetail;
import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.enumdomain.OrderStatus;
import com.minh.teashop.repository.CartDetailRepository;
import com.minh.teashop.repository.CartRepository;
import com.minh.teashop.repository.OrderDetailRepository;
import com.minh.teashop.repository.OrderRepository;
import com.minh.teashop.repository.ProductRepository;

import jakarta.servlet.http.HttpSession;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, UserService userService, OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public List<Product> getListProducts() {
        List<Product> listProducts = this.productRepository.findAll();
        return listProducts;
    }

    public Product handleSaveProduct(Product product) {
        return this.productRepository.save(product);
    }

    public Optional<Product> fetchProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void handleDeleteProduct(long id) {

        this.productRepository.deleteById(id);

    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                Cart newCart = new Cart();
                newCart.setUser(user);
                newCart.setSum(0);
                cart = this.cartRepository.save(newCart);

            }
            Optional<Product> p = this.productRepository.findById(productId);
            if (p.isPresent()) {
                Product product = p.get();
                CartDetail currentCartDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);
                if (currentCartDetail == null) {
                    CartDetail cd = new CartDetail();
                    cd.setCart(cart);
                    cd.setProduct(product);
                    cd.setPrice(product.getPrice());
                    cd.setQuantity(1);
                    this.cartDetailRepository.save(cd);
                    long sum = cart.getSum() + 1;
                    cart.setSum(sum);
                    this.cartRepository.save(cart);
                    session.setAttribute("cartSum", sum);

                } else {
                    currentCartDetail.setQuantity(currentCartDetail.getQuantity() + quantity);
                    this.cartDetailRepository.save(currentCartDetail);
                }

            }

        }
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handleDeleteCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();
            Cart currentCart = cartDetail.getCart();
            this.cartDetailRepository.deleteById(cartDetailId);

            if (currentCart.getSum() > 0) {
                long sum = currentCart.getSum() - 1;

                currentCart.setSum(sum);
                session.setAttribute("cartSum", sum);
                this.cartRepository.save(currentCart);

            } else {
                this.cartRepository.deleteById(cartDetailId);
                session.setAttribute("cartSum", 0);

            }
        }
    }

    public void handleUpdateCartDetailBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currenCartDetail = cdOptional.get();
                currenCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currenCartDetail);
            }
        }

    }

    public void handlePlaceOrder(User user, HttpSession session, Address receiverAddress) {
        // create Oder
        Order order = new Order();
        order.setUser(user);
        order.setReceiverAddress(receiverAddress.getFullAddress());
        order.setReceiverName(receiverAddress.getReceiverName());
        order.setReceiverPhone(receiverAddress.getReceiverPhone());
        order.setStatus(OrderStatus.PENDING);
        order.setOrderDate(LocalDate.now());
        order = this.orderRepository.save(order);

        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();
            if (cartDetails != null) {
                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getPrice());
                    orderDetail.setQuantity(cd.getQuantity());

                    this.orderDetailRepository.save(orderDetail);

                }
                for (CartDetail cd : cartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }
                this.cartRepository.delete(cart);

                session.setAttribute("cartSum", 0);

            }
        }
    }
}
