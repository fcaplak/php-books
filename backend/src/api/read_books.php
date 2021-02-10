<?php
    require_once('api_include.php');

    if ($_SERVER["REQUEST_METHOD"] == "GET")
    {
        $stmt = $conn->prepare("SELECT knihy.name, knihy.isbn, knihy.price, kategorie.name AS category, autori.name AS author FROM ((knihy INNER JOIN kategorie ON knihy.category=kategorie.id) INNER JOIN autori ON knihy.author=autori.id) ORDER BY knihy.id");
        
        $stmt->execute();
        $result = $stmt->get_result();

        $output_array = array();
        while($row = $result->fetch_object()) {
            $row->price = number_format($row->price, 2, '.', ' ');
            $output_array[] = $row;
        }

        echo json_encode($output_array, JSON_PRETTY_PRINT);

        $stmt->close();
    }

    $conn->close();

?>