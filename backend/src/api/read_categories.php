<?php
    require_once('api_include.php');

    if ($_SERVER["REQUEST_METHOD"] == "GET")
    {
        $stmt = $conn->prepare("SELECT kategorie.id, kategorie.name FROM kategorie");

        $stmt->execute();
        $result = $stmt->get_result();

        $output_array = array();
        while($row = $result->fetch_object()) {
            $output_array[] = $row;
        }

        echo json_encode($output_array, JSON_PRETTY_PRINT);

        $stmt->close();
    }

    $conn->close();

?>