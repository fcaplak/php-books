<?php
    require_once('api_include.php');

    if ($_SERVER["REQUEST_METHOD"] == "GET")
    {
        if( isset($_GET['term']) )
        {
            $param = "%{$_GET['term']}%";
            $stmt = $conn->prepare("SELECT `name` FROM `autori` WHERE `name` LIKE ?");
            $stmt->bind_param("s", $param);
        }
        else
        {
            $stmt = $conn->prepare("SELECT `name` FROM `autori`");
        }

        $stmt->execute();
        $result = $stmt->get_result();

        $output_array = array();
        while($row = $result->fetch_object()) {
            $output_array[] = $row->name;
        }

        echo json_encode($output_array, JSON_PRETTY_PRINT);

        $stmt->close();
    }
    
    $conn->close();

?>