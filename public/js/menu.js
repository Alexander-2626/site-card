document.addEventListener('DOMContentLoaded', function () {
  var burger = document.querySelector('.site-burger');
  var nav = document.querySelector('.site-nav');
  if (!burger || !nav) return;

  burger.addEventListener('click', function () {
    var open = nav.classList.toggle('is-open');
    burger.setAttribute('aria-expanded', open ? 'true' : 'false');
  });
});