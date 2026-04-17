<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="col-10 col-md-4 mt-4">
        <div class="input-container">
            <textarea class="form-control floating-input" id="incdtCmt" name="incdtCmt" rows="1" placeholder=""></textarea>
            <label for="incdtCmt" class="floating-label">text Area</label>
        </div>
    </div>
    
<div class="col-md-4 mt-4" >
    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="MeetingReq" id="MeetingReq" >
         <label class="form-label fw-bold d-block">Send Meeting Request </label>
    </div>
</div>	

 		<div class="col-4 mt-2">
                <div class="input-container">
			    <label class="form-label d-block">Follow Up IN/OUT</label>
			
			    <div class="form-check form-check-inline">
			        <input class="form-check-input" type="radio" id="in" name="inorout" value="in">
			        <label class="form-check-label" for="in">IN</label>
			    </div>
			
			    <div class="form-check form-check-inline">
			        <input class="form-check-input" type="radio" id="out" name="inorout" value="out" checked>
			        <label class="form-check-label" for="out">OUT</label>
			    </div>
			</div>
        </div>
     
<!--Text   -->   
	       <div class="col-4 mt-3">
	        <div class="input-container">
	          <input class="form-control floating-input" type="text" id="UserName" name="UserName" placeholder="" required>
	          <label for="Username" class="floating-label">User Name</label>
	        </div>
      		</div>
      
<!--Select TAG  -->
	       <div class="col-4">
	        <div class="input-container">    
	        <label class="tcolor">User Level</label>
	            <select class="form-select" id="UserLevel" name="UserLevel" required>            
	           	<option value="Level1">Level 1</option>
				<option value="Level2">Level 2</option>
				<option value="Level3">Level 3</option>
				<option value="Level4">Level 4</option>
				<option value="Level5">Level 5</option>
	           
	           </select>
	        </div>
	      </div>

<!-- Delete-->						
					<td class="text-center">
					<a href="#" style="font-weight: bold; color: black;" onclick="DeleteRow()">
					<i class='bx bxs-trash' style="color:red;font-size: 20px;"></i></a></td>
					
<!--Edit   -->
					<td><a href="EmployeeEditForm.jsp?empid=" style="font-weight: bold; color: black;" onclick="">
					<i class='bx bxs-edit' style="color:green;font-size: 20px;"></i></a></td>
					
</body>
</html>