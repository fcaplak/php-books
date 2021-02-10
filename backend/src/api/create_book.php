<?php
    require_once('api_include.php');

    $error_flag = "0";
    $message = "";

    $response = array();
    $response['error'] = $error_flag;
    $response['invalid'] = array();

    
    if ($_SERVER["REQUEST_METHOD"] == "POST")
    {
        $book = json_decode(file_get_contents("php://input"));

        if (empty($book->name)) { $error_flag = "1"; $response['invalid']['name'] = "Názov knihy je potrebné vyplniť"; }

        // validate ISBN
        if ( !preg_match("/^([0-9]{10}|[0-9]{13})$/", $book->isbn ))
        {
            $error_flag = "1"; $response['invalid']['isbn'] = "ISBN je v nesprávnom formáte";
        }

        if (empty($book->price) || !is_numeric($book->price) || $book->price < 0.0 ) { $error_flag = "1"; $response['invalid']['price'] = "Cena musí byť kladné desatinné číslo"; }
        if (empty($book->category)) { $error_flag = "1"; $response['invalid']['category'] = "Je potrebné vybrať kategóriu"; }
        if (empty($book->author)) { $error_flag = "1"; $response['invalid']['author'] = "Je potrebné vyplniť autora";}

        if( $error_flag == "0")
        {
            $stmt = $conn->prepare("SELECT `id` FROM `autori` WHERE `name` = ?");
            $stmt->bind_param("s", $book->author);
            $stmt->execute();
            $result = $stmt->get_result();
            $author = $result->fetch_object();

            if( $result->num_rows > 0 )
            {
                $author_id = $author->id;
            }
            else
            {
                $stmt = $conn->prepare("INSERT INTO `autori` (`name`) VALUES (?)");
                $stmt->bind_param("s", $book->author);
                $stmt->execute();

                $stmt = $conn->prepare("SELECT LAST_INSERT_ID() AS id FROM `autori`");
                $stmt->execute();
                $result = $stmt->get_result();

                $insert = $result->fetch_object();
                $author_id = $insert->id;
                
            }

            $stmt = $conn->prepare("INSERT INTO `knihy` (`name`, `isbn`, `price`, `category`, `author`) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("ssdss", $book->name, $book->isbn, $book->price, $book->category, $author_id);
            $stmt->execute();
            
            $stmt->close();

            $response['success'] = "Bola pridaná nová kniha";
        }
        
        $response['error'] = $error_flag;

        $conn->close();

        echo json_encode($response, JSON_PRETTY_PRINT);
    }
?>