<%
if module_doc then
	from = "modules/"..module_doc.name
elseif file_doc then
	from = "files/.."..file_doc.name
else
	from = ""
end
%>

<dt><%=func.private and "local " or ""%><a name="<%=func.name%>"></a><strong><%=func.name%></strong>&nbsp;(<%=table.concat(func.param, ", ")%>)</dt>
<dd>
<%=func.description or ""%>

<%if type(func.param) == "table" and #func.param > 0 then%>
<h3>Parameters:</h3>
<ul>
	<%for p = 1, #func.param do%>
	<li>
	  <code><em><%=func.param[p]%></em></code>: <%=func.param[func.param[p]] or ""%>
	</li>
	<%end%>
</ul>
<%end%>

<%if func.usage then%>
<div>
<%if type(func.usage) == "string" then%>
<h3 class="inline-block">Usage:</h3>
<%=func.usage%>
<%elseif type(func.usage) == "table" then%>
<h3>Usage:</h3>
<ul>
	<%for _, usage in ipairs(func.usage) do%>
	<li><%= usage %></li>
	<%end%>
</ul>
<%end%>
</div>
<%end%>

<%if func.ret then%>
<div>

<%if type(func.ret) == "string" then%>
<h3 class="inline-block">Return value:</h3>
<%=func.ret%>
<%elseif type(func.ret) == "table" then%>
<h3>Return values:</h3>
<ol>
	<%for _, ret in ipairs(func.ret) do%>
	<li><%= ret %></li>
	<%end%>
</ol>
<%end%>
</div>
<%end%>


<%if func.example then%> 
<div>
<%if type(func.example) == "string" then%>
<h3 class="inline-block">Example:</h3>
<pre class="example"><%=func.example%></pre>
<%elseif type(func.example) == "table" then%>
<h3>Example:</h3>
<ul>
	<%for _, example in ipairs(func.example) do%>
	<pre class="example"><%= example %></pre>
	<%end%>
</ul>
<%end%>
</div>
<%end%>

<%if func.see then%>
<div>
<%if type(func.see) == "string" then %>
<h3 class="inline-block">See also:</h3>
	<a href="<%=func.see%>"><%=func.see%></a>
<%elseif type(func.see) == "table" and #func.see > 0 then %>
<h3>See also:</h3>
<ul>
	<%for i = 1, #func.see do%>
	<li><a href="<%=luadoc.doclet.html.symbol_link(func.see[i], doc, module_doc, file_doc, from).href%>">
		<%=luadoc.doclet.html.symbol_link(func.see[i], doc, module_doc, file_doc, from).display%>
	</a></li>
	<%end%>
</ul>
<%end%>
</div>
<%end%>

</dd>
