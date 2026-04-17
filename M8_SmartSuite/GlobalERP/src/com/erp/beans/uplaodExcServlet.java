package com.erp.beans;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.erp.beans.DisplayData;

public class uplaodExcServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	public uplaodExcServlet() {	
		super();
System.out.println("constructor calll");
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		System.out.println("IN UPLAOD EXCEL SERVLET PAGE      >>>  ");

		//HttpSession session=request.getSession();
	
		PrintWriter pw=response.getWriter();
		ArrayList<DisplayData> disp=null;
		String Flag="true";
		String directory = getServletContext().getRealPath("/") + "images";
		System.out.println("directory..."+directory);
		
		FileUpload fileUpload = new FileUpload();
		try {
		disp= fileUpload.uploadFile(request,directory);
		System.out.println("back to page again"+disp);
		} catch (Exception e1) {

		}

	request.setAttribute("InvalidList", disp);
		
    RequestDispatcher rd = request.getRequestDispatcher("DisplayInvalidData.jsp");  
    rd.forward(request, response); 

	}
}
