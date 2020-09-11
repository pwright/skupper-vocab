---
inject: true
to: index.html
before: .*inject-blocks-above.*
---
            <div class="block">
                <label><%=attribute%></label>
                <input type="text" id="<%=attribute%>" name="<%=attribute%>">

            </div>
