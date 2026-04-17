 

	function show(vehcode,par1,par2,targetvalue1,target2,selecteduser,distformat){
		document.getElementById("h3id").style.display = "block";
//		document.getElementById("companies").style.display = "block";	
		var queryString ="?vehcode="+vehcode+"&par1="+par1+"&par2="+par2+"&targetvalue1="+targetvalue1+"&target2="+target2+"&selecteduser="+selecteduser+"&distformat="+distformat;
    	alert("Query String"+queryString);
    	alert("Base PAt:---"+basePath);
			  $("#companies").dataTable({
					
			        lengthMenu: [
	      	            [ 10, 25, 50, -1 ],
	      	            [ '10 Rows' , '25 Rows', '50 Rows', 'Show all' ],
	      	            
	      	        ],	
			    //    "bJQueryUI": true,
			        "aoColumns": [
			        	
			            { "mDataProp": "SrNo" },
	                      { "mDataProp": "DateTime" },
	                      { "mDataProp": "Speed" },
	                      { "mDataProp": "Distance" },
	                      { "mDataProp": "Event" },
	                      { "mDataProp": "Value" },
	                      { "mDataProp": "Location" },
	                      { "mDataProp": "Sen1" },
	                      { "mDataProp": "Sen2" },
	                      { "mDataProp": "Sen3" },
	                      { "mDataProp": "Sen4" },
			                  ],
			                  dom: 'Blfrtip',
			      	        "bLengthChange" : false,
			      	        buttons: [
			      	        	
			      	        	{
			      	        		extend: 'collection',
			      	        		
			      	        		text: 'Export',
			      	        		buttons: [
			      	        			{
			      	                        extend: 'excel',
			      	                        title: 'Detail Report '+$("#data").val()+'-'+$("#data1").val(), 
			      	                    },
			      	                    {
			      	                        extend: 'pdf',
			      	                        orientation: 'landscape',
			      	                        pageSize: 'LEGAL',
			      	                      title: 'Detail Report '+$("#data").val()+'-'+$("#data1").val(), 
			      	                    },
			      	                    {
			      	                        extend: 'csv',
			      	                      title: 'Detail Report '+$("#data").val()+'-'+$("#data1").val(),
			      	                    },
			      	                    {
			      	                        extend: 'print',
			      	                      title: 'Detail Report '+$("#data").val()+'-'+$("#data1").val(),
			      	                    },
			      	                    {
			      	                        extend: 'copy',
			      	                      title: 'Detail Report '+$("#data").val()+'-'+$("#data1").val(),
			      	                    },
			      	                    
			      	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
			      	            				
			      	                    
			      	            			]
			      	        	},
			      	        	
			      	            'colvis',
			      	            'pageLength'
			      	        ],
			      	        
			      	        
			      	        "oLanguage": {
			      	        	   "sSearch": "Search"
			      	        	 },
			      	        	
			      	           //"bServerSide": true,
			      	          /* "sAjaxSource": "/FleetviewLocal/VehicleGsonObjectsServlet3"+queryString, */ 
                            // "sAjaxSource": "./VehicleGsonObjectsServlet3"+queryString,  
			      	          // "bProcessing": true,
			      	         /* "type": "POST"zzz */
		/* 	      	               "bProcessing": true,
        "bServerSide": true,
        "sAjaxSource": "./VehicleGsonObjectsServlet3"+queryString,
        "bJQueryUI": true, */
     //   "bJQueryUI" : true,
        "sPaginationType" : "full_numbers",
        //"iDisplayLength": 10,
        "bProcessing" : true,
        "bServerSide" : true,
        "sAjaxSource" : basePath +"/VehicleGsonObjectsServlet3"+queryString,
	      	         
			      	         
			      //	         
			      	           "sPaginationType": "full_numbers",
			      	         "bDestroy": true
			      	          
			      	                 	        
			      	            
			      	       
			      	   
			      	    
			    });
	}
	 jQuery.extend(jQuery.fn.dataTableExt.oSort, {
		 "date-uk-pre": function ( a ) {
		    var ukDatea = a.split('/');
		    return (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1;
		 },

		 "date-uk-asc": function ( a, b ) {
		    return ((a < b) ? -1 : ((a > b) ? 1 : 0));
		 },

		 "date-uk-desc": function ( a, b ) {
		    return ((a < b) ? 1 : ((a > b) ? -1 : 0));
		 }
		 } );   
	 

 
 
  
