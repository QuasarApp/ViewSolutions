import QtQuick

Canvas {
    id: root
    property real progress: 0.7
    property real lineWidth: 16

    property color color: tokensModel.color_surface_accent_primary
    property color backgroundColor: tokensModel.color_border_secondary

    height: implicitHeight
    width: implicitWidth

    onProgressChanged: requestPaint()
    onPaint: {
        const ctx = getContext("2d");
        const centerX = width / 2;
        const centerY = height / 2;
        const outerRadius = Math.min(width, height) / 2;
        const innerRadius = outerRadius - root.lineWidth;

        ctx.clearRect(0, 0, width, height);

        // background
        const endAngle = 2 * Math.PI * 0.9999; // if we drow all circle the is will be filled include inner content.
        ctx.beginPath();
        ctx.arc(centerX, centerY, outerRadius, -Math.PI / 2, endAngle - Math.PI / 2, false);
        ctx.arc(centerX, centerY, innerRadius, endAngle - Math.PI / 2, -Math.PI / 2, true);
        ctx.closePath();
        ctx.fillStyle = root.backgroundColor;
        ctx.fill();

        // progress
        const endProgressAngle = 2 * Math.PI * progress * 0.9999;
        ctx.beginPath();
        ctx.arc(centerX, centerY, outerRadius, -Math.PI / 2, endProgressAngle - Math.PI / 2, false);
        ctx.arc(centerX, centerY, innerRadius, endProgressAngle - Math.PI / 2, -Math.PI / 2, true);
        ctx.closePath();
        ctx.fillStyle = root.color;
        ctx.fill();

        if (progress < 1) {
            // round of angles
            // begin circly
            ctx.beginPath();
            const roundRadius = root.lineWidth / 2;
            ctx.arc(centerX + Math.cos(-Math.PI / 2) * (outerRadius - roundRadius ), centerY + Math.sin(-Math.PI / 2) * (outerRadius - roundRadius), roundRadius, 0, 2 * Math.PI, false);
            ctx.fillStyle = root.color;
            ctx.fill();

            // last circli
            if (progress > 0) {
                ctx.beginPath();
                ctx.arc(centerX + Math.cos(endAngle - Math.PI / 2) * (outerRadius - roundRadius), centerY + Math.sin(endAngle - Math.PI / 2) * (outerRadius - roundRadius), roundRadius, 0, 2 * Math.PI, false);
                ctx.fillStyle = root.color;
                ctx.fill();
            }
        }

    }
}
