<div class="container-fluid">
	<form action="AddNoteServlet" id="addNote" method="post">
		<input type="hidden" name="folderId" value="${folderId}">
		<div style="display: flex; justify-content: flex-end;">
			<button type="button" class="btn btn-primary btn-center" id="add-Note">Add</button>
		</div>
		<div class="mb-3">
			<label for="note-tital" class="form-label fw-bold">Title<span style="color: red">*</span>:</label> 
			<input type="text" name="tital" class="form-control" id="note-tital" required="required">
		</div>
		<div class="mb-3">
			<label for="note-content" class="form-label fw-bold">Note Content:</label>
			<textarea class="form-control" name="content" id="note-content" style="min-height: 30rem;"></textarea>
		</div>		
	</form>
</div>

<!--Success Modal -->
<div class="modal fade" id="sucess-modal" tabindex="-1"
	aria-labelledby="sucess-modal-Label" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="sucess-modal-Label" style="color: green;">Success</h1>
			</div>
			<div class="modal-body" id="success-body">
			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>					
			</div>
		</div>
	</div>
</div>

<!--Error Modal -->
<div class="modal fade" id="error-modal" tabindex="-1"
	aria-labelledby="error-modal-Label" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="error-modal-Label" style="color: red;">Error</h1>
			</div>
			<div class="modal-body" id="error-body">
			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>					
			</div>
		</div>
	</div>
</div>

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> -->
<script type="text/javascript">
	
	$(document).ready(function(){
		$("#add-Note").click(function(){
			var formData = $('#addNote').serialize();
			$.ajax({
				url: $('#addNote').attr('action'),
                type: $('#addNote').attr('method'), 
				data: formData,
				success : function(response){
					let $result = $(response).find("#notes-mainContent").html();
					$("#notes-mainContent").html($result);	
					$("#note-tital").val('');
					$("#note-content").val('');
					$("#addNoteContainer").hide();
					$("#showNoteContainer").show();					
				},
				beforeSend: function () {
					$("body").addClass("loader");
	            },
	            complete: function () {
	            	$("body").removeClass("loader");		            	
	            }
			})
		});
	});
</script>
