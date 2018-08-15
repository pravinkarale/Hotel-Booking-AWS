$(document).ready(function(){
	$( ".datepik" ).datepicker({
	  dateFormat: "dd-mm-yy",
	  onSelect: function(dateText) {
    	var which_date = $(this).prop('id');
    	if ($('#start_date').val() == '' || $('#start_date').val() == 'undefined')
				{
					alert("Please select Start Date")
				}
			else{
				if($('#end_date').val() == '') {
					
				}
				else{
					var start_date = $('#start_date').val();
					var end_date = $('#end_date').val();
					var category_id = $('#category_id').val(); 
					$.ajax({
	            type: "get",
	            url: "/get_available_booking?category_id="+category_id+"&start_date="+start_date+"&end_date="+end_date 
	          });
        } 
			}	
  	}
	});	
})





