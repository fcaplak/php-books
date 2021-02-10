var sorted_table = 0;

function draw_table(json_data){
  var content = '';
  sorted_table ? data = sortByKey(json_data, 'price') : data = json_data

  for (var i=0, l=data.length; i<l; i++) {
    var obj = data[i];
    content += '<tr><td style="width: 30%">'+obj.name+'</td><td style="width: 20%">'+obj.isbn+'</td><td style="width: 10%">'+obj.price+' &euro;</td><td style="width: 15%">'+obj.category+'</td><td style="width: 25%">'+obj.author+'</td></tr>'
  }
  $('#tablebody').html('');
  $('#tablebody').html(content);
  content = '';
}

function sortByKey(array, key){
  return array.sort(function(a, b) {
      var x = Number(a[key]); var y = Number(b[key]);
      return ((x < y) ? -1 : ((x > y) ? 1 : 0));
  });
}

$(function(){
  $( "#sort" ).click(function() {
    sorted_table = 1;
    draw_table(content_data);
  });
 
});


