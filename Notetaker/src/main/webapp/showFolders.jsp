<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<jsp:include page="bootstrap.jsp"></jsp:include>
		<link rel="stylesheet" type="text/css" href="css/navbar.css">	
		<link rel="stylesheet" type="text/css" href="css/loader.css">
	</head>
	<body>
		<jsp:include page="navbar.jsp"></jsp:include>
		<div id="showFoldersContainer" >
			<div class="container-fluid" style="display: flex; justify-content: flex-end; margin-bottom: 0.8rem;">
				<button type="button" class="btn btn-primary" onclick="$('#create-folder-modal').modal('show')">Create Folder</button>
			</div>
			<div class="container-fluid">
				<div id="mainContent" >		
					<c:choose>
						<c:when test="${folders == null ||  folders.isEmpty()}">				
							<div style="display: flex;justify-content: center; font-size: 20px; font-weight: 700; color: red">No Folders Available</div>
						</c:when>
						<c:otherwise>
							<form action="FolderServlet" method="post" id="formDeleteFolder" >
								<input type="hidden" name="directive" >
								<input type="hidden"  name="folderId" >
								<c:forEach   var="folder" items="${folders}"> 						
					            	<div class="note-item" style="margin-bottom: 1rem">
										<div class="card" style="width: 100%;">								
											<div class="card-body" style="overflow: hidden;">									    										    
											    <div style="display: flex;flex-direction: column; gap: 1.8rem;">
													<div style="display: flex;  justify-content: space-between;">
														<div  style="display: flex; gap:0.6rem;">
															<img style="height: 25px;"  alt="img" src="img/icon-folder.png">
															<h5 class="card-title"><c:out value="${folder.name}"/></h5>
														</div>
														<p style="color: #000000;font-size: 14px;">${folder.createdOn}</p>															
													</div>
													<div style="display: flex; justify-content: flex-end; gap:0.8rem;">									  
													  <!-- <a href="#" class="btn btn-secondary" >Rename</a> -->
													  <c:if test="${folder.id ne 1}">
													  	<a href="#" class="btn btn-danger" onclick="deleteFolder(${folder.id})" >Delete</a>
													  </c:if>
													  <a href="#" class="btn btn-secondary" onclick="viewFolderNotes(${folder.id})" >View</a>
													</div>	
												</div>														
											</div>
										</div>
									</div>
					        	 </c:forEach>
					        </form>	
						</c:otherwise>		
					</c:choose>				
				</div>
			</div>
		</div>
		
		<div id="showNotesContainer" style="display: none;" class="container-fluid">
		
		
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="create-folder-modal" tabindex="-1" aria-labelledby="create-folder-modal-lable" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="create-folder-modal-lable">Create Folder</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <form action="FolderServlet" method="post" id="formCreateFolder">
		        	  <input type="hidden" value="createFolder" name="directive" >
					  <div class="mb-3">
					    <label for="exampleInputEmail1" class="form-label" >Name</label>
					    <input type="text" class="form-control" name="folderName" id="folder-name">
					  </div>
					  <div style="display: flex;justify-content: flex-end;">
					  	<button type="button" class="btn btn-primary" id="create-folder">Create</button>
					  </div>
				</form>
		      </div>
		    </div>
		  </div>
		</div>
		
		<script type="text/javascript">
		$(document).ready(function(){
			$("#create-folder").click(function(){
				$.ajax({
					url: $('#formCreateFolder').attr('action'),
                    type: $('#formCreateFolder').attr('method'), 
                    data : $('#formCreateFolder').serialize(),
                    success : function(responce){
                    	let $result = $(responce).find("#mainContent").html(); 
                    	$("#mainContent").html($result);
                    },
                    beforeSend : function(){
                    	$("body").addClass("loader");
                    },
                    complete : function(){
                    	$("#folder-name").val('');
                    	$('#create-folder-modal').modal('hide');
                    	$("body").removeClass("loader");	
                    }
				})
			});			
		});
		
		function deleteFolder(id){
			$('#formDeleteFolder').find('input[name="folderId"]').val(id);
			$('#formDeleteFolder').find('input[name="directive"]').val("deleteFolder");
			$.ajax({
				url: $('#formDeleteFolder').attr('action'),
                type: $('#formDeleteFolder').attr('method'), 
                data : $('#formDeleteFolder').serialize(),
                success : function(responce){
                	let $result = $(responce).find("#mainContent").html(); 
                	$("#mainContent").html($result);
                },
                beforeSend : function(){
                	$("body").addClass("loader");
                },
                complete : function(){
                	$("body").removeClass("loader");	
                }
			});
		}
		
		function viewFolderNotes(id) {
			$.ajax({
				url: "ShowNotes?folderId=" + id,
                type: "Get", 
                success : function(responce){
                	console.log("Inside note");
                	let $result = $(responce).filter("#NotesContainer").html(); 
                	$("#showNotesContainer").html($result);
                	$("#showNotesContainer").show();
                	$("#showFoldersContainer").hide();
                },
                beforeSend : function(){
                	$("body").addClass("loader");
                },
                complete : function(){                	
                	$("body").removeClass("loader");	
                }
			});
		}
		</script>
	</body>
</html>