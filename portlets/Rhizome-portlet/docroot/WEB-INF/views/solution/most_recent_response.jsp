<%@include file="../init.jsp"%>

<c:forEach items="${solutionList}" var="solution">
	<portlet:renderURL var="viewAnswerURL">
		<portlet:param name="view" value="viewSolution" />
		<portlet:param name="solutionId" value="${solution.solutionId}" />
	</portlet:renderURL>
			<tr>
				<td><div class="sg-recent-title01"><a href="<%=viewAnswerURL.toString() %>">${solution.solutionTitle}</a></div></td>
			</tr>
			
</c:forEach>