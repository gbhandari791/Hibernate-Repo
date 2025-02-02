package com.notetaker.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.notetaker.entity.Folder;
import com.notetaker.helper.FactoryProvider;

@WebServlet("/FolderServlet")
public class FolderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public FolderServlet() {
        super();        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Session session = FactoryProvider.getFactory().openSession();
			String sqlString = "from Folder f order by (case when f.name = 'Default Folder' then 1 else 2 end), f.id desc";
			Query<Folder> query = session.createQuery(sqlString, Folder.class);
			List<Folder> listFolders = query.list();
			request.setAttribute("folders", listFolders);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("showFolders.jsp");
			requestDispatcher.forward(request, response);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String directive = request.getParameter("directive");
			if("createFolder".equalsIgnoreCase(directive)) {
				String folderName = request.getParameter("folderName");
				createFolder(folderName);
			} else if("deleteFolder".equalsIgnoreCase(directive)) {
				int folderId = Integer.parseInt(request.getParameter("folderId"));
				deleteFolder(folderId);
			}
			response.sendRedirect("FolderServlet");			
		} catch (Exception e) {
			
		}
	}
	
	private void createFolder(String folderName) {		
		Session session = FactoryProvider.getFactory().openSession();
		Transaction tr = session.beginTransaction();
		Folder folder = new Folder();
		folder.setName(folderName);
		session.save(folder);
		tr.commit();
		session.close();
	}
	
	private void deleteFolder(int folderId) {
		try {
			Session session = FactoryProvider.getFactory().openSession();
			Transaction tr = session.beginTransaction();
			Folder folder = session.get(Folder.class, folderId);
			session.delete(folder);
			tr.commit();
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
