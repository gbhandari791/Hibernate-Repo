<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Show Notes</title>
    <jsp:include page="bootstrap.jsp"></jsp:include>
    <link rel="stylesheet" href="css/navbar.css">
    <link rel="stylesheet" type="text/css" href="css/loader.css">	
</head>
<body>

	<jsp:include page="navbar.jsp"></jsp:include>

	<div class="container-fluid" id="NotesContainer" >
		<div id="addNoteContainer" style="display: none;">
			<jsp:include page="addNote.jsp"></jsp:include>
		</div>
		<div id="showNoteContainer">
			<div class="container-fluid" style="display: flex; justify-content: space-between; margin-bottom: 0.8rem;">
					<div> 
						<c:if test="${not empty folder and not empty folder.name}">
						    <div style="font-weight: 700; font-size: 20px;">${folder.name}</div>
						</c:if>
					</div>
					<button type="button" class="btn btn-primary" onclick="createNote()" >Create Note</button>	
			</div>
			<div id="notes-mainContent" >			
				<c:choose>
					<c:when test="${allNotes == null ||  allNotes.isEmpty()}">				
						<div style="display: flex;justify-content: center; font-size: 20px; font-weight: 700; color: red">No Notes Available</div>
					</c:when>
					<c:otherwise>
						<c:forEach   var="note" items="${allNotes}"> 
				            <div class="note-item" style="margin-bottom: 1rem">
								<div class="card" style="width: 100%;">
									<div class="card-body" style=" overflow: hidden; display: flex;flex-direction: column;">
										<div style="display: flex;justify-content: space-between;">
											<div  style="display: flex; gap:0.6rem;">
												<img style="height: 25px;"  alt="img" src="img/icon-note.png"> 
												<h5 class="card-title"><c:out value="${note.title}"/></h5>
											</div>
											<p style="color: #000000;font-size: 14px;">${note.createdOn}</p>	
										</div>
										<p class="card-text" style="margin-left: 35px;"><c:out value="${note.content}"/></p>
										<div style="display: flex; justify-content: flex-end; gap:0.8rem; align-self: flex-end;">
										  <a href="#" class="btn btn-danger" onclick="deleteNote(${note.id}, '${folderId}')">Delete</a>
										   <a href="#" class="btn btn-secondary" onclick="viewNote(${note.id})">View</a>
										</div>						
									</div>
								</div>
							</div>
				         </c:forEach>
					</c:otherwise>		
				</c:choose>				
			</div>
		</div>
		
		<div class="container-fluid" id="viewNoteContent" style="display: none;">
		
		</div>
		
		<script type="text/javascript">
			function deleteNote(noteId, folderId) {
				console.log("inside ready");
				console.log(folderId);
				$.ajax({
					url : "DeleteServlet?noteId=" + noteId +"&folderId=" + folderId,
					type : "Get",
					success : function(response){		
						console.log(response);
						let $result = $(response).find("#notes-mainContent").html();	
						console.log( $result);
						$("#notes-mainContent").html($result);
					}, 
					beforeSend: function () {
						$("body").addClass("loader");
		            },
		            complete: function () {
		            	$("body").removeClass("loader");		            	
		            }
				})
			}
			
			function viewNote(noteId) {
				console.log("inside ready");
				$.ajax({
					url : "ViewNoteServlet?noteId=" + noteId,
					type : "Get",
					success : function(response){	
						let $result = $(response).filter("#viewNoteContent");
						$("#showNoteContainer").hide();
						$("#viewNoteContent").html($result);
						$("#viewNoteContent").show();
					}, 
					beforeSend: function () {
						$("body").addClass("loader");
		            },
		            complete: function () {
		            	$("body").removeClass("loader");		            	
		            }
				});
			}
			
			function createNote() {
				$("#addNoteContainer").show();
				$("#showNoteContainer").hide();
			}
		</script>
	</div>
</body>
</html>
