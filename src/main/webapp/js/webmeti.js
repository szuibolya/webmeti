/**
 * 
 */

function storestockdate_list_loadtable(bdate,edate){
	/*alert("storestockdate_list_loadtable "+bdate+" "+edate);*/
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	var t = document.getElementById('storestockdate-list-table');
	    	t.innerHTML = this.responseText;	
	    	$('.container').addClass('container-fluid').removeClass('container');
	    	$('#myTable').pageMe({pagerSelector:'#myPager',showPrevNext:true,hidePageNumbers:false,perPage:8});
	    }	    
	  };
	  xhttp.open("GET", "menuaction.jsp?sid="+sessionStorage.sid+"&mid=menu_storestockdate_list"+"&lang="+sessionStorage.lang+"&bdate="+bdate+"&edate="+edate+"&flag=1", true);
	  xhttp.send();
	}