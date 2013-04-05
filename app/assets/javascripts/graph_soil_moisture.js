var graph_data = [];
var deptha_data = [];
var depthb_data = [];
var depthc_data = [];

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

    parse_depth_data(graph_data, deptha_data, "deptha");
    parse_depth_data(graph_data, depthb_data, "depthb");
    parse_depth_data(graph_data, depthc_data, "depthc");

    console.log(deptha_data);
    console.log(depthb_data);
    console.log(depthc_data);
}

function parse_depth_data(allData, depth_data, set_depth) {
    for (i=0; i < allData.length; i++) {

        for (c=0; c < allData[i].length; c++) {
            depth_data.push(allData[i][c][set_depth]);
        }

    }
}

