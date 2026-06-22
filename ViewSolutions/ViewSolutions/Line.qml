import QtQuick

Item {
    id: root

    // Target points that change constantly
    property real pointAX: 0
    property real pointAY: 0

    property real pointBX: 0
    property real pointBY: 0

    property alias sourceRect: line


    Rectangle {
        id: line
        x: root.pointAX
        y: root.pointAY - height / 2 // Center the line vertically on Point A

        // Calculate the distance (width of the rectangle) using Pythagorean theorem
        width: Math.sqrt(Math.pow(root.pointBX - root.pointAX, 2) + Math.pow(root.pointBY - root.pointAY, 2))
        height: 2

        // Set the transform origin to the start of the line (Point A)
        transformOrigin: Item.Left

        // Calculate the angle using arctangent
        rotation: Math.atan2(root.pointBY - root.pointAY, root.pointBX - root.pointAX) * 180 / Math.PI
    }
}