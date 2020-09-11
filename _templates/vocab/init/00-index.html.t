---
to: index.html
---
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Vocab</title>
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Open+Sans:300,300italic,400,400italic,600,600italic%7CNoto+Serif:400,400italic,700,700italic%7CDroid+Sans+Mono:400,700">
    <link rel="stylesheet" href="./simple.css">
    <style>
        body {
            font-family: Arial;
        }

        /* Style the tab */
        .tab {
            overflow: hidden;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
        }

        /* Style the buttons inside the tab */
        .tab button {
            background-color: inherit;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 14px 16px;
            transition: 0.3s;
            font-size: 17px;
        }

        /* Change background color of buttons on hover */
        .tab button:hover {
            background-color: #ddd;
        }

        /* Create an active/current tablink class */
        .tab button.active {
            background-color: #ccc;
        }

        /* Style the tab content */
        .tabcontent {
            display: none;
            padding: 6px 12px;
            border: 1px solid #ccc;
            border-top: none;
        }
    </style>

</head>

<body onload="fetchParams()">

    <script src="./asciidoctor.js"></script>

    <div class="tab">
        <button class="tablinks" onclick="openCity(event, 'Content')" id="defaultOpen">Content</button>
        <button class="tablinks" onclick="openCity(event, 'Attributes')">Attributes</button>
        <button class="tablinks" onclick="openCity(event, 'OutputAsciiDoc')">Output Asciidoc</button>

    </div>


    <div id="Content" class="tabcontent">
        <div id="content"></div>
    </div>


    <div id="Attributes" class="tabcontent">

        <form action="index.html" method="GET">



            <br class="inject-blocks-above"> 
            <input type="submit" value="Set Attributes">

        </form>
        <br>
       
    </div>

    <div id="OutputAsciiDoc" class="tabcontent">
       
    </div>

    <script>

        function fetchParams() {


            // inject-fetch

        }

        function getQueryStringValue(name) {
            var params = new URLSearchParams(window.location.search.substring(1));
            return params.get(name);
        }

        function getHashParam(name) {
            var params = window.location.hash.substring(1).split('&');
            console.log(params);
            for (var i = 0; i < params.length; i++) {
                if (params[i].split('=')[0].toLowerCase() === name.toLowerCase()) {
                    return params[i].split('=')[1]
                }
            }
        }

        function getAttributesFromQueryParameters() {
            var query = location.search.substr(1);
            var result = '';
            query.split("&").forEach(function (part) {
                var item = part.split("=");
                var key = item[0];
                var value = item[1];
                if (typeof value !== 'undefined') {
                    value = value.replace(/\+/g, '%20');
                    var escapedValue = decodeURIComponent(value);
                    result = result.concat(":" + key + ":").concat(" " + escapedValue + "\n");
                    //console.log(result);
                } else {
                    result = result.concat(key);
                }

            });
            return result;
        }

        var asciidoctor = Asciidoctor()
        var attributesQueryParameters = getAttributesFromQueryParameters();
        var attributes = '';
        if (attributesQueryParameters) {
            attributes = attributes.concat('').concat(attributesQueryParameters);
        }


        var html = asciidoctor.convert('\n\n' + attributes + '\n\ninclude::doc.adoc[leveloffset=+1]', { safe: 'unsafe', attributes: [] })

        document.getElementById('content').innerHTML = html

        var x = document.createElement("TEXTAREA");
        var t = document.createTextNode(attributes);
        x.appendChild(t);
        x.cols = "80";
        x.rows = "40"
        document.getElementById("OutputAsciiDoc").appendChild(x);

    </script>
    <script>
        function openCity(evt, cityName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += " active";
        }

        // Get the element with id="defaultOpen" and click on it
        document.getElementById("defaultOpen").click();
    </script>

</body>

</html>