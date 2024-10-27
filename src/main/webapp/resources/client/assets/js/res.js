let btnNext = document.querySelector("button.auth__intro-next");
let authContent = document.querySelector("#auth-content");

if (btnNext && authContent) {
  btnNext.addEventListener("click", clickNext);

  function clickNext() {
    authContent.classList.replace("hide", "show");
  }
}
