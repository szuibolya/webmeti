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

function orderinfo_supplier_loadtable(bdate,edate,dtype_id,chk0,chk1,chk2,chk3,chk4,chk5,chk6,chk7){
	alert("storestockdate_list_loadtable "+bdate+" "+edate);
	var statuslista = "";
	if (chk0) statuslista += "'0',";
	if (chk1) statuslista += "'1',";
	if (chk2) statuslista += "'2',";
	if (chk1) statuslista += "'3',";
	if (chk1) statuslista += "'4',";
	if (chk1) statuslista += "'5',";
	if (chk1) statuslista += "'6',";
	if (chk1) statuslista += "'7',";
	if (statuslista.length > 0) statuslista = statuslista.substr(0,statuslista.length-1);
	
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	var t = document.getElementById('tree-list-table');
	    	t.innerHTML = this.responseText;	
	    	$('.container').addClass('container-fluid').removeClass('container');
	    	$('#myTable').pageMe({pagerSelector:'#myPager',showPrevNext:true,hidePageNumbers:false,perPage:8});
	    }	    
	  };
	  xhttp.open("GET", "menuaction.jsp?sid="+sessionStorage.sid+"&mid=menu_orderinfo_supplier"+"&lang="+sessionStorage.lang+"&bd="+bdate+"&ed="+edate+"&flag=1"+"&dtype_id="+dtype_id+"&direction=1&satuslista="+statuslista, true);
	  xhttp.send();
	}