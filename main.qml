import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Chess")

    Grid
    {
        id: board
        signal clicked
        anchors.margins: 20
        anchors.bottomMargin: 80
        anchors.centerIn: parent
        columns: 8
        property int cur_coloumn: 1
        property int cur_row: 1
        Repeater{
            id: rptr
            model: { var cells = [true];
                for(var i=1; i<64; i++) cells[i]=false;
                    return cells;}
            Rectangle{
                id: cell
                property int coloumn: Math.floor(index / 8) + 1
                property int row: index % 8 + 1
                width: 55
                height: 55
                color: {
                    if( ((coloumn + row) % 2) == 1)
                    {
                           if(rptr.model[index]) return "#423f3f";
                            else return "black";
                    }
                    else { if(rptr.model[index]) return "#b9a469";
                        else return "#e4dbdb";
                        }
                }
                border.width: 2
                border.color: {
                    if((Math.abs(cell.coloumn - board.cur_coloumn) == 1 && Math.abs(cell.row - board.cur_row) == 2)
                            || (Math.abs(cell.coloumn - board.cur_coloumn) == 2 && Math.abs(cell.row - board.cur_row) == 1)) "red"
                    else "grey"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if ((Math.abs(cell.coloumn - board.cur_coloumn) == 1 && Math.abs(cell.row - board.cur_row) == 2)
                                || (Math.abs(cell.coloumn - board.cur_coloumn) == 2 && Math.abs(cell.row - board.cur_row) == 1))
                        {
                            if(!rptr.model[index])
                            {
                                board.cur_coloumn = cell.coloumn
                                board.cur_row = cell.row
                                knight.moveTo(cell.coloumn, cell.row);
                                var tmp = rptr.model;
                                tmp[index] = true;
                                rptr.model =tmp;
                            }
                        }
                        }
                    }
                }



        }
    }
    Image{
        id: knight
        x:board.x
        y:board.y
        source: "knight.png"
        width: 55
        height: 55
        function moveTo(coloumn, row)
        {
           knight.x = board.x+ (row-1)*55
           knight.y = board.y+ (coloumn-1)*55
        }
    }
}

