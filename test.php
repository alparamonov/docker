<?php
//http://stor03haufe.blob.core.windows.net/2017/product-a/zips/200MB

    $prod = $_GET['prod'];
    $ind = mt_rand(1, 3);
    $path = "http://stor0" . $ind . "haufe.blob.core.windows.net/2017/product-a/zips/" . $prod;

    header('HTTP/1.1 301 Moved Permanetly');
    header("Location: ". $path);

    echo $path;
?>
