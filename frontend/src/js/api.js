var content_data = '';

$(function(){
    function get_books(){
      $.ajax({ 
        type: 'GET', 
        url: api_url+'/read_books.php', 
        dataType: 'json',
        contentType: 'application/json',
        success: function(json_data) {
          content_data = json_data;
          draw_table(json_data);
        },
      });
    }

    function get_categories(){
      $.ajax({ 
        type: 'GET', 
        url: api_url+'/read_categories.php', 
        dataType: 'json',
        contentType: 'application/json',
        success: function(data) {
          for (var i=0, l=data.length; i<l; i++) {
            var obj = data[i];
            $('#category').append('<option name="'+obj.id+'">'+obj.name+'</option>');
          }
        },
      });
    }

    $("form").submit(function(e){ 
      e.preventDefault();

      var formData = {
          'name'      : $('input[name=name]').val(),
          'isbn'      : $('input[name=isbn]').val(),
          'price'     : $('input[name=price]').val(),
          'category'  : $( "#category option:selected" ).attr('name'),
          'author'    : $('input[name=author]').val(),
      };
      $.ajax({ 
        type: 'POST', 
        url: api_url+'/create_book.php', 
        data: JSON.stringify(formData),
        dataType: 'json',
        contentType: 'application/json',
        success: function(data){

          $("input").removeClass("is-invalid");
          $("select").removeClass("is-invalid");
          $('#name-invalid').hide();
          $('#isbn-invalid').hide();
          $('#price-invalid').hide();
          $('#category-invalid').hide();
          $('#author-invalid').hide();

          if( data.error == 0 )
          {
            $('#success_box').html(data.success);
            $('#success_box').show();
            setTimeout(function(){ $('#success_box').fadeOut('slow'); }, success_fade_time*1000);

            get_books();
            $('form')[0].reset();
          }
          else
          {
            if(data.invalid.name != null)
            {
              $('input[name=name]').addClass( "is-invalid" );
              $('#name-invalid').html(data.invalid.name);
              $('#name-invalid').show();
            }

            if(data.invalid.isbn != null)
            {
              $('input[name=isbn]').addClass( "is-invalid" );
              $('#isbn-invalid').html(data.invalid.isbn);
              $('#isbn-invalid').show();
            }

            if(data.invalid.price != null)
            {
              $('input[name=price]').addClass( "is-invalid" );
              $('#price-invalid').html(data.invalid.price);
              $('#price-invalid').show();
            }

            if(data.invalid.category != null)
            {
              $('select[name=category]').addClass( "is-invalid" );
              $('#category-invalid').html(data.invalid.category);
              $('#category-invalid').show();
            }

            if(data.invalid.author != null)
            {
              $('input[name=author]').addClass( "is-invalid" );
              $('#author-invalid').html(data.invalid.author);
              $('#author-invalid').show();
            }
          }
          },
      });
    });

    $( "#author" ).autocomplete({
      source: api_url+'/read_authors.php'
    });

    get_books();
    get_categories();

  });