var slideIndex = 1;
showSlides(slideIndex);
autoSlides();
var s = 1;

function autoSlides(){
    setInterval(function(){
        plusSlides(s);
    }, 2000);
}

function plusSlides(n) {
    showSlides(slideIndex += n);
}

function currentSlide(n) {
    showSlides(slideIndex = n);
}

function showSlides(n) {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("dot");
    if (n > slides.length) {slideIndex = 1}
    if (n < 1) {slideIndex = slides.length}
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }
    try{
        slides[slideIndex-1].style.display = "block";
        dots[slideIndex-1].className += " active";
    }catch(error){ }
}

document.getElementById("banner").addEventListener("mouseover", function(){
	document.getElementById("blink").style.opacity = "100%";
});
document.getElementById("banner").addEventListener("mouseleave", function(){
	document.getElementById("blink").style.opacity = "0%";
});