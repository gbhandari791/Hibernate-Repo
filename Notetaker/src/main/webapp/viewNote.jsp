<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>View Note</title>
		<jsp:include page="bootstrap.jsp"></jsp:include>
		<link rel="stylesheet" type="text/css" href="css/loader.css">	
	</head>
	<body>
		<div id="viewNoteContent">
			<form action="UpdateNoteServlet" id="updateNoteForm" method="post">
				<input type="hidden" name="noteId" value="${viewNote.id}">
				<div style="display: flex; justify-content: flex-end;">
					<button type="button" class="btn btn-primary btn-center"
						id="updateNote">Update</button>
				</div>
				<div class="mb-3">
					<label for="note-tital" class="form-label fw-bold">Title<span
						style="color: red">*</span>:
					</label> <input value="${viewNote.title}" type="text" name="title"
						class="form-control" id="note-tital" required="required">
				</div>
				<div class="mb-3">
					<label for="note-content" class="form-label fw-bold">Note Content:</label>
					<textarea class="form-control" name="content" id="note-content"
						style="min-height: 30rem;">${viewNote.content}</textarea>
				</div>				
			</form>
		

		<!--Success Modal -->
		<div class="modal fade" id="un-sucess-modal" tabindex="-1"
			aria-labelledby="un-sucess-modal-Label" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="un-sucess-modal-Label"
							style="color: green;">Success</h1>
					</div>
					<div class="modal-body" id="un-success-body"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

		<script type="text/javascript">
		
			$(document).ready(function() {
				$("#updateNote").click(function() {
					console.log("Inside update");
					$.ajax({
						url : $('#updateNoteForm').attr('action'),
						type : $('#updateNoteForm').attr('method'),
						data: $("#updateNoteForm").serialize(),
						success : function(responce) {
							$("#un-success-body").html("Note Updated Successfully!");
							$("#un-sucess-modal").modal('show');
						},
						beforeSend : function() {
							$("body").addClass("loader");
						},
						complete : function() {
							$("body").removeClass("loader");
						}
	
					});
				});
			});
		</script>
	 </div>
</body>
</html>