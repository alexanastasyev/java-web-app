<%--suppress XmlDefaultAttributeValue, ELValidationInJSP --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Welcome, Dispatcher</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/script.js" ></script>
</head>
    <body onload="noBack()">
        <h1>Welcome, Dispatcher</h1>
        <hr/>
        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <th>No</th>
                            <th>Captain</th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                        <c:forEach var="pierAssignment" items="${pierAssignments}" varStatus="status">
                            <c:if test="${pierAssignment.getRequestStatus().getTitle().equals('requested_arrival') || pierAssignment.getRequestStatus().getTitle().equals('requested_department')}">
                                <tr>
                                    <td>${pierAssignment.getId()}</td>
                                    <td>${pierAssignment.getCaptain().getLogin()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${pierAssignment.getRequestStatus().getTitle().equals('requested_arrival')}">
                                                Arrival request
                                            </c:when>
                                            <c:otherwise>
                                                Department request
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <form method="post" action="controller">
                                            <input type="hidden" name="pierAssignmentId" value="${pierAssignment.getId()}">
                                            <c:choose>
                                                <c:when test="${pierAssignment.getRequestStatus().getTitle().equals('requested_arrival')}">
                                                    <input type="hidden" name="command" value="approve_arrival_request"/>
                                                    <label>
                                                        Pier:
                                                        <select name="chosenPier">
                                                            <c:forEach var="pierWithAssignment" items="${piersWithAssignments}">
                                                                <c:if test="${pierWithAssignment.getValue() == null}">
                                                                    <option value="${pierWithAssignment.getKey().getId()}">${pierWithAssignment.getKey().getId()}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </label>
                                                    <input type="submit" value="Approve"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="hidden" name="command" value="approve_department_request"/>
                                                    <input type="submit" value="Approve"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <th>No</th>
                            <th>Captain</th>
                        </tr>
                        <c:forEach var="pierWithAssignment" items="${piersWithAssignments}" varStatus="status">
                            <tr>
                                <td>${pierWithAssignment.getKey().getId()}</td>
                                <td>${pierWithAssignment.getValue().getLogin()}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </td>
            </tr>
        </table>
    <hr/>
    <a href="controller?command=logout">Logout</a>
    </body>
</html>
