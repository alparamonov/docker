<?php
//http://stor03haufe.blob.core.windows.net/2017/product-a/zips/200MB

   // $prod = $_GET['prod'];
   // $ind = mt_rand(1, 3);
   // $path = "http://stor0" . $ind . "haufe.blob.core.windows.net/2017/product-a/zips/" . $prod;
    //$path = "https://stor01haufe.blob.core.windows.net/live/loadtest/product-a/200MB.zip";
    $path = "http://ipv4.download.thinkbroadband.com/5MB.zip";
    header("HTTP/1.1 301 Moved Permanently");
    header("Location: " . $path);

    echo $path;
?>
