var graph_data = [];

$.ajax({
    type: 'GET',
    url: "http://localhost:3000/sites/1.json",
    success: function(data) { setData(data); },
    contentType: 'application/json',
    dataType: 'json'
});

function setData(data) {

    for (i=0; i < data.length; i++) {
        graph_data.push(data[i].soilMoisture);
    }
    console.log(graph_data);
}
