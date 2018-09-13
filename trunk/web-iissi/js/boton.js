/*para poder mostrar los vinculos en la parte responsive */
function myToggleMenu() {
    var x = document.getElementById("myTopnav");
    if (x.className === "topnav") {
        x.className += " responsive";
    } else {
        x.className = "topnav";
    }
}

function vistaCarrito() {
    var x = document.getElementById("miCarrito");
     if (x.style.display === "block") {
        x.style.display = "none";
    } else {
        x.style.display = "block";
    }
 }
