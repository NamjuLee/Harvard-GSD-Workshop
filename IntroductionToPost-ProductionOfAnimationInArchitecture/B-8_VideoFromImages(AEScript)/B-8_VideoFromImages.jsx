
app.beginUndoGroup("Layers to Maskers");
//var myLayer = app.project.activeItem.layer(1);


var time = 4;
var transition = 1;
var scaleFactor = 1.3;
var total_num = app.project.numItems;

var theComp = app.project.item(total_num);
//alert(total_num);


function trimLayer(object, invalue, outvalue){
    object.inPoint = invalue;
    object.outPoint = outvalue;
}

function moveLayer(object, interval){
    object.startTime = interval
}

for (var i = 1; i <= theComp.numLayers; i++){
    
    var obj = theComp.layer(i)

    trimLayer(obj, 0, time);
    

    myOpacity = obj.opacity;
    myOpacity.setValueAtTime(time-transition, 100);
    myOpacity.setValueAtTime(time, 0);

    myScale = obj.scale;
    myScale.setValueAtTime(0, [100,100,100]);
    myScale.setValueAtTime(time, [100*scaleFactor,100*scaleFactor,100*scaleFactor]);

    theInterVal = (time-transition)*i;
    moveLayer(obj, theInterVal);
    }

app.endUndoGroup();