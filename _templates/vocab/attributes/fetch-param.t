---
inject: true
to: index.html
before: .*inject-fetch.*
---
            document.getElementById('<%=attribute%>').value = getQueryStringValue('<%=attribute%>');
