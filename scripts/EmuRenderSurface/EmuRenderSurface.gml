function EmuRenderSurface(_x, _y, _w, _h, _render, _control, _create, _destroy) : EmuCore(_x, _y, _w, _h) constructor {
    SetRender = function(_render) {
        callback_render = method(self, _render);
    }
    
    SetControl = function(_control) {
        callback_control = method(self, _control);
    }
    
    SetRecreate = function(_recreate) {
        callback_recreate = method(self, _recreate);
    }
    
    SetDestroy = function(_destroy) {
        callback_destroy = method(self, _destroy);
    }
    
    SetRender(_render);
    SetControl(_control);
    method(self, _create)();
    SetDestroy(_destroy);
    
    callback_recreate = function() {
        surface_set_target(surface);
        draw_clear(c_black);
        surface_reset_target();
    }
    
    surface = surface_create(width, height);
    surface_set_target(surface);
    draw_clear(c_black);
    surface_reset_target();
    
    Recreate = function() {
        
    }
    
    Render = function(base_x, base_y) {
        var x1 = x + base_x;
        var y1 = y + base_y;
        var x2 = x1 + width;
        var y2 = y1 + height;
        
        if (!surface_exists(surface)) {
            surface = surface_create(width, height);
            callback_recreate();
        }
        
        callback_control(x1, y1, x2, y2);
        
        surface_set_target(surface);
        var camera = camera_get_active();
        var old_view_mat = camera_get_view_mat(camera);
        var old_proj_mat = camera_get_proj_mat(camera);
        var old_state = gpu_get_state();
        callback_render(x1, y1, x2, y2);
        camera_set_view_mat(camera, old_view_mat);
        camera_set_proj_mat(camera, old_proj_mat);
        camera_apply(camera);
        gpu_set_state(old_state);
        ds_map_destroy(old_state);
        surface_reset_target();
        
        draw_surface(surface, x1, y1);
    }
    
    Destroy = function() {
        DestroyContent();
        if (surface_exists(surface)) surface_free(surface);
        callback_destroy();
    }
}