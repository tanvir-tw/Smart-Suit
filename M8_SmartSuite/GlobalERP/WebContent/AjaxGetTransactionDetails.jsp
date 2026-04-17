<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.*" %>
<%@ include file="conn.jsp" %>
<%! // helper to safe-get string 
    public String safe(String s){ return s==null?"":s; }
%>
<%
    // Logging
    System.out.println("in AjaxGETTransaction_rewritten.jsp ##############################");

    String cust = request.getParameter("cctype");
    String empName = session.getAttribute("EmpName")!=null?session.getAttribute("EmpName").toString():"";
    String companyMasterId = session.getAttribute("CompanyMasterID")!=null?session.getAttribute("CompanyMasterID").toString():"";

    // Response buffer
    StringBuilder outBuf = new StringBuilder();

    // Common date formatter
    SimpleDateFormat srcDate = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat outDate = new SimpleDateFormat("dd-MMM-yyyy");

    try (Connection con = DriverManager.getConnection(DB_NAME, DB_USERNAME, DB_PASSWORD)) {
        Class.forName(DB_Driver);

        if (cust != null && cust.equalsIgnoreCase("Prospect")) {
            // ---------- PROSPECT FLOW ----------
            String company = safe(request.getParameter("company"));
            String companyName = safe(request.getParameter("companyName"));

            // Count contacts
            String countSql = "SELECT COUNT(*) AS cnt FROM " + companyMasterId + "contactdet WHERE customercode=? AND mobileno <> 'null'";
            int contactCount = 0;
            try (PreparedStatement psCount = con.prepareStatement(countSql)) {
                psCount.setString(1, company);
                try (ResultSet rsCount = psCount.executeQuery()) {
                    if (rsCount.next()) contactCount = rsCount.getInt("cnt");
                }
            }

            // Fetch followups (limit 3)
            String followSql = "SELECT FollowUpDate,FollowUpType,NextFollowUpDate,Comments,MarketingRepcode FROM "
                    + companyMasterId + "followup WHERE ProspCustName=? AND FollowUpType <> 'Assigned' ORDER BY FollowUpDate DESC LIMIT 3";

            try (PreparedStatement ps = con.prepareStatement(followSql)) {
                ps.setString(1, companyName);
                try (ResultSet rs = ps.executeQuery()) {

                    // Header card
                    outBuf.append("<div class='card' style='background-color:azure;'>");
                    outBuf.append("<div class='card-body p-2'>");
                    outBuf.append("<div class='data-card2'><div class='card-body p-2'><div class='row align-items-center'>");
                    outBuf.append("<div class='col-2'></div><div class='col-10'><div class='row'>");
                    outBuf.append("<div class='col-2'><h6><b>Follow up date</b></h6></div>");
                    outBuf.append("<div class='col-2'><h6><b>Type</b></h6></div>");
                    outBuf.append("<div class='col-3'><h6><b>Next Follow up</b></h6></div>");
                    outBuf.append("<div class='col-3'><h6><b>Comments</b></h6></div>");
                    outBuf.append("<div class='col-2'><h6><b>EnteredBy</b></h6></div>");
                    outBuf.append("</div></div></div></div></div>");

                    // Row cards
                    while (rs.next()) {
                        String followDate = safe(rs.getString("FollowUpDate"));
                        String type = safe(rs.getString("FollowUpType"));
                        String nextFollow = safe(rs.getString("NextFollowUpDate"));
                        String comments = safe(rs.getString("Comments"));
                        String repcode = safe(rs.getString("MarketingRepcode"));

                        // Resolve entered by from global user master
                        String enteredBy = "-";
                        String userSql = "SELECT EmpName FROM db_GlobalERP.UserMaster WHERE companymasterid=? AND EmpCode=? LIMIT 1";
                        try (PreparedStatement psU = con.prepareStatement(userSql)) {
                            psU.setString(1, companyMasterId);
                            psU.setString(2, repcode);
                            try (ResultSet rsU = psU.executeQuery()) {
                                if (rsU.next()) {
                                    String n = rsU.getString("EmpName");
                                    if (n != null && !n.trim().isEmpty()) enteredBy = n;
                                }
                            }
                        }

                        outBuf.append("<div class='data-card1'><div class='card-body p-2'><div class='row align-items-center'>");
                        outBuf.append("<div class='col-2'><img src=\"imagesnew/bulletlist.webp\" alt=\"..\" style=\"width:90px;height:50px;\"></div>");
                        outBuf.append("<div class='col-10'><div class='row'>");

                        // follow date
                        String fd = "";
                        try { if(!followDate.isEmpty()) fd = outDate.format(srcDate.parse(followDate)); } catch(Exception ex){ fd = followDate; }
                        outBuf.append("<div class='col-2'><p>"+fd+"</p></div>");

                        // type
                        outBuf.append("<div class='col-2'><p>"+type+"</p></div>");

                        // next follow
                        String nd = "";
                        try { if(!nextFollow.isEmpty()) nd = outDate.format(srcDate.parse(nextFollow)); } catch(Exception ex){ nd = nextFollow; }
                        outBuf.append("<div class='col-3'><p>"+nd+"</p></div>");

                        // comments
                        outBuf.append("<div class='col-3'><p>"+comments+"</p></div>");

                        // entered by
                        outBuf.append("<div class='col-2'><p>"+enteredBy+"</p></div>");

                        outBuf.append("</div></div></div></div>");
                    }

                    // Print assigned by marker and contact count at the end same format as original
                    out.println(outBuf.toString() + "#assigned by#" + contactCount + "#");
                }
            }

        } else {
            // ---------- COMPANY FLOW ----------
            String company = safe(request.getParameter("company"));
            String companyName = safe(request.getParameter("companyName"));

            // Transaction (last 3)
            String transSql = "SELECT TransactionDate,TransactionDetail,CreditAmount,DebitAmount,Balance FROM "
                    + companyMasterId + "customerledgeraccount WHERE CustomerCode=? ORDER BY concat(TransactionDate, TransactionId) DESC LIMIT 3";

            StringBuilder txBuf = new StringBuilder();

         // ---------- HEADER CARD ----------
         txBuf.append(
             "<div class='data-card mt-1'>"
           + "  <div class='card-body p-2'>"
           + "    <div class='row align-items-center'>"
           + "      <div class='col-2'></div>"
           + "      <div class='col-10'>"
           + "        <div class='row'>"
           + "          <div class='col-3'><h6><b>Date</b></h6></div>"
           + "          <div class='col-3'><h6><b>Id</b></h6></div>"
           + "          <div class='col-2'><h6><b>Credit</b></h6></div>"
           + "          <div class='col-2'><h6><b>Debit</b></h6></div>"
           + "          <div class='col-2'><h6><b>Balance</b></h6></div>"
           + "        </div>"
           + "      </div>"
           + "    </div>"
           + "  </div>"
           + "</div>"
         );


         // ---------- DATA CARDS ----------
         try (PreparedStatement psTx = con.prepareStatement(transSql)) {
             psTx.setString(1, company);
             try (ResultSet rsTx = psTx.executeQuery()) {

                 while (rsTx.next()) {

                     String tDate = safe(rsTx.getString("TransactionDate"));
                     String tDetail = safe(rsTx.getString("TransactionDetail"));
                     String credit = safe(rsTx.getString("CreditAmount"));
                     if (credit.isEmpty()) credit = "0.00";
                     String debit = safe(rsTx.getString("DebitAmount"));
                     String balance = safe(rsTx.getString("Balance"));

                     String td = "";
                     try {
                         if (!tDate.isEmpty())
                             td = outDate.format(srcDate.parse(tDate));
                     } catch (Exception ex) {
                         td = tDate;
                     }

                     txBuf.append(
                         "<div class='data-card mt-1'>"
                       + "  <div class='card-body p-2' style='border: 1px cadetblue;border-style: ridge;'>"
                       + "    <div class='row align-items-center'>"
                       + "      <div class='col-2'>"
                       + "        <img src='imagesnew/bulletArrow.jpg' style='width:60px;height:35px;'>"
                       + "      </div>"
                       + "      <div class='col-10'>"
                       + "        <div class='row'>"
                       + "          <div class='col-3'><p>" + td + "</p></div>"
                       + "          <div class='col-3'><p>" + tDetail + "</p></div>"
                       + "          <div class='col-2'><p>" + credit + "</p></div>"
                       + "          <div class='col-2'><p>" + debit + "</p></div>"
                       + "          <div class='col-2'><p>" + balance + "</p></div>"
                       + "        </div>"
                       + "      </div>"
                       + "    </div>"
                       + "  </div>"
                       + "</div>"
                     );
                 }
             }
         }

         txBuf.append("#");  // keep existing separator

            // Contact count
            String countSql = "SELECT COUNT(*) AS cnt FROM " + companyMasterId + "contactdet WHERE salesCustomerCode=? AND mobileno <> 'null'";
            int contactCount = 0;
            try (PreparedStatement psCnt = con.prepareStatement(countSql)) {
                psCnt.setString(1, company);
                try (ResultSet rsCnt = psCnt.executeQuery()) {
                    if (rsCnt.next()) contactCount = rsCnt.getInt("cnt");
                }
            }

            // Followups (like prospect)
            String followSql = "SELECT FollowUpDate,FollowUpType,NextFollowUpDate,Comments,MarketingRepcode FROM "
                    + companyMasterId + "followup WHERE ProspCustName=? AND FollowUpType <> 'Assigned' ORDER BY FollowUpDate DESC LIMIT 3";

            StringBuilder followBuf = new StringBuilder();
            try (PreparedStatement ps = con.prepareStatement(followSql)) {
                ps.setString(1, companyName);
                try (ResultSet rs = ps.executeQuery()) {
                    // Header card
                    followBuf.append("<div class='card' style='background-color:azure;'>");
                    followBuf.append("<div class='card-body p-1'>");
                    followBuf.append("<div class='data-card2'><div class='card-body p-1'><div class='row align-items-center'>");
                    followBuf.append("<div class='col-2'></div><div class='col-10'><div class='row'>");
                    followBuf.append("<div class='col-2'><h6><b>Follow up date</b></h6></div>");
                    followBuf.append("<div class='col-2'><h6><b>Type</b></h6></div>");
                    followBuf.append("<div class='col-3'><h6><b>Next Follow up</b></h6></div>");
                    followBuf.append("<div class='col-3'><h6><b>Comments</b></h6></div>");
                    followBuf.append("<div class='col-2'><h6><b>EnteredBy</b></h6></div>");
                    followBuf.append("</div></div></div></div></div>");

                    while (rs.next()) {
                        String followDate = safe(rs.getString("FollowUpDate"));
                        String type = safe(rs.getString("FollowUpType"));
                        String nextFollow = safe(rs.getString("NextFollowUpDate"));
                        String comments = safe(rs.getString("Comments"));
                        String repcode = safe(rs.getString("MarketingRepcode"));

                        // Resolve entered by
                        String enteredBy = "-";
                        String userSql = "SELECT EmpName FROM db_GlobalERP.UserMaster WHERE companymasterid=? AND EmpCode=? LIMIT 1";
                        try (PreparedStatement psU = con.prepareStatement(userSql)) {
                            psU.setString(1, companyMasterId);
                            psU.setString(2, repcode);
                            try (ResultSet rsU = psU.executeQuery()) {
                                if (rsU.next()) {
                                    String n = rsU.getString("EmpName");
                                    if (n != null && !n.trim().isEmpty()) enteredBy = n;
                                }
                            }
                        }

                        followBuf.append("<div class='data-card1'><div class='card-body p-1'><div class='row align-items-center'>");
                        followBuf.append("<div class='col-2'><img src=\"imagesnew/bulletlist.webp\" alt=\"..\" style=\"width:60px;height:30px;\"></div>");
                        followBuf.append("<div class='col-10'><div class='row'>");

                        String fd = ""; try { if(!followDate.isEmpty()) fd = outDate.format(srcDate.parse(followDate)); } catch(Exception ex){ fd = followDate; }
                        followBuf.append("<div class='col-2'><p>"+fd+"</p></div>");

                        followBuf.append("<div class='col-2'><p>"+type+"</p></div>");

                        String nd = ""; try { if(!nextFollow.isEmpty()) nd = outDate.format(srcDate.parse(nextFollow)); } catch(Exception ex){ nd = nextFollow; }
                        followBuf.append("<div class='col-3'><p>"+nd+"</p></div>");

                        followBuf.append("<div class='col-2'><p>"+comments+"</p></div>");
                        followBuf.append("<div class='col-3'><p>"+enteredBy+"</p></div>");

                        followBuf.append("</div></div></div></div></div>");
                    }
                }
            }

            // Combine and print: transactions + followups + marker
            out.println(txBuf.toString() + followBuf.toString() + "#assigned by#" + contactCount + "#");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("ERROR: " + e.getMessage());
    }
%>
