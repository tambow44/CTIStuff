#!/bin/bash

home=$(dirname "$0")

# *** Variables ***

EmailToAddress=""
EmailFromAddress=""
Subject="Merry Christmas!"
Attachment="$home/images/xmas.png"

# *** Script ***

sendmail -t <<EOT
TO: $EmailToAddress
FROM: <$EmailFromAddress>
SUBJECT: $Subject
MIME-Version: 1.0
Content-Type: multipart/related;boundary="XYZ"

--XYZ
Content-Type: text/html; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

<html>
        <head>
                <meta http-equiv="content-type" content="text/html; charset=ISO-8859-15">
        </head>

        <body bgcolor="#ffffff" text="#000000">
                <p><a href="https://youtu.be/qi0kWe2ixzU">The Ghost of Tom Joad</a> wishes you a Merry Christmas!</p>
                <img src="cid:part1.06090408.01060107" alt="">
        </body>
</html>

--XYZ
Content-Type: image/png;name="$Attachment"
Content-Transfer-Encoding: base64
Content-ID: <part1.06090408.01060107>
Content-Disposition: inline; filename="$Attachment"

$(base64 $Attachment)
--XYZ--
EOT
