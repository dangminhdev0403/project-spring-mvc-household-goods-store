package com.minh.teashop.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Collaborator;
import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.Withdrawal;
import com.minh.teashop.domain.dto.WithdrawRequest;
import com.minh.teashop.domain.enumdomain.OrderStatus;
import com.minh.teashop.domain.enumdomain.WithdrawStatus;
import com.minh.teashop.repository.CollaboratorRepository;
import com.minh.teashop.repository.OrderDetailRepository;
import com.minh.teashop.repository.WithdrawalRepository;

import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class AffiliateService {

    private final OrderDetailRepository detailRepository;
    private final CollaboratorRepository collaboratorRepository;
    private final WithdrawalRepository withdrawalRepository;

    @Transactional
    public void updateAllCommissionRates(double newCommissionRate) {
        this.collaboratorRepository.updateAllCommissionRates(newCommissionRate);
    }

    public Collaborator findCollaboratorByUser(User user) {
        return this.collaboratorRepository.findByUser(user);
    }

    public double handldeGetCommission() {
        Collaborator existingCollaborator = this.collaboratorRepository.findTopByCommissionRateNot(0);
        if (existingCollaborator != null) {
            double commissionRate = existingCollaborator.getCommissionRate();

            return commissionRate;
        }

        return 0;

    }

    public long getCountOrderByAffilateId(long id) {
        return this.detailRepository.countByAffiliateId(id);
    }

    public void updateCollaborator(User userAffiliate, double commission) {
        Collaborator currenComparator = userAffiliate.getCollaborator();
        if (currenComparator != null) {
            double balance = currenComparator.getBalance() + commission;
            ;

            currenComparator.setBalance(balance);
            this.collaboratorRepository.save(currenComparator);

        }

    }

    public void updateCollaborator(User userAffiliate, double commission, Order order) {
        Collaborator currenComparator = userAffiliate.getCollaborator();
        if (currenComparator != null) {
            OrderStatus prevStatus = order.getPrevStatus();
            OrderStatus currentStatus = order.getStatus();

            if (prevStatus != null) {
                if (prevStatus != OrderStatus.DELIVERED && currentStatus == OrderStatus.DELIVERED) {
                    // Hoa hồng được ghi nhận khi chuyển sang trạng thái DELIVERED
                    currenComparator.setBalance(currenComparator.getBalance() - commission);
                    currenComparator.setTotalEarnings(currenComparator.getTotalEarnings() + commission);
                    currenComparator.setAvailableBalance(currenComparator.getAvailableBalance() + commission);
                } else if (prevStatus == OrderStatus.DELIVERED && currentStatus != OrderStatus.DELIVERED) {
                    // Hoàn lại hoa hồng nếu trạng thái chuyển từ DELIVERED về trạng thái khác
                    currenComparator.setBalance(currenComparator.getBalance() + commission);
                    currenComparator.setTotalEarnings(currenComparator.getTotalEarnings() - commission);
                    currenComparator.setAvailableBalance(currenComparator.getAvailableBalance() - commission);
                }
            }

            this.collaboratorRepository.save(currenComparator);

        }

    }

    public Page<User> getListUserByAffiliateId(long affiliateId, Pageable pageable) {
        return detailRepository.findUsersByAffiliateId(affiliateId, pageable);
    }

    public Page<OrderDetail> getOrdersByAffiliateIds(long affiliateId, Pageable pageable) {
        return this.detailRepository.findByAffiliateId(affiliateId, pageable);
    }

    public boolean handleWithdrawal(WithdrawRequest withdrawRequest, Collaborator collaborator) {

        if (collaborator == null)
            return false;

        double availableBalance = collaborator.getAvailableBalance();
        double amount = Double.parseDouble(withdrawRequest.getWithdrawAmount()) * 1000;

        if (amount <= availableBalance) {
            availableBalance = availableBalance - amount;
            collaborator.setAvailableBalance(availableBalance);

            this.collaboratorRepository.save(collaborator);
            Withdrawal withdrawal = new Withdrawal();
            withdrawal.setAmount(Double.parseDouble(withdrawRequest.getWithdrawAmount()));
            withdrawal.setStatus(WithdrawStatus.PENDING);
            withdrawal.setCollaborator(collaborator);
            withdrawal.setBankSelect(withdrawRequest.getBankSelect());
            withdrawal.setAccountName(withdrawRequest.getAccountName());
            withdrawal.setAccountNumber(withdrawRequest.getAccountNumber());
            this.withdrawalRepository.save(withdrawal);
        } else {
            return false;
        }

        return true;
    }
}
