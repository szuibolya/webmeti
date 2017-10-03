/**
 * 
 */

function mhandler(e,x) {
	
x.style.background = "white";
x.previousElementSibling.style.display = "none";
x.previousElementSibling.previousElementSibling.style.display = "none";
x.nextElementSibling.style.display = "none";
x.nextElementSibling.nextElementSibling.style.display = "none";
if(e.clientX<20)
 {
  x.style.background = "red";  
  x.previousElementSibling.style.display = "table-cell";
 }
if(e.clientX>x.offsetWidth-20)
 {
  x.style.background = "blue";
  x.nextElementSibling.style.display = "table-cell";
 }
if(e.clientY<20)
 {
  x.style.background = "yellow";
  x.previousElementSibling.previousElementSibling.style.display = "table-row";
 }
if(e.clientY>x.offsetHeight-20)
 {
  x.style.background = "green";
  x.nextElementSibling.nextElementSibling.style.display = "table-row";
 }
}