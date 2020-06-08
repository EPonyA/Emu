function VText(_x, _y, _w, _h, _text, _root) : VCore(_x, _y, _w, _h, _root) constructor {
    text = _text;
    
    GetTextX = function(_x) {
        switch (alignment) {
            case fa_left: return _x + offset;
            case fa_center: return _x + width / 2;
            case fa_right: return _x + width - offset;
        }
    }
    
    GetTextY = function(_y) {
        switch (valignment) {
            case fa_left: return _y + offset;
            case fa_center: return _y + height / 2;
            case fa_right: return _y + height - offset;
        }
    }
    
    Render = function(base_x, base_y) {
        var x1 = x + base_x;
        var y1 = y + base_y;
        var x2 = x1 + width;
        var y2 = y1 + height;
        
        var tx = GetTextX(x1);
        var ty = GetTextY(y1);
        
        scribble_set_wrap(width, height);
        scribble_set_box_align(alignment, valignment);
        scribble_draw(tx, ty, text);
    }
    
    // Inherited:
    // SetTooltip()
    // Destroy()
}