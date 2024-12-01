window.onload = function(){

    var menu = document.getElementById("mainList");
    var chi = menu.children;
    for(var i = 0; i < chi.length; i++){
        chi[i].addEventListener("mouseover", function(){
            this.children[1].style.opacity = "100%";
        });
        chi[i].addEventListener("mouseleave", function(){
            this.children[1].style.opacity = "0%";
        });
    }
    
}