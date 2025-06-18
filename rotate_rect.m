function corners = rotate_rect(w, h, angle)
    base = 0.5 * [
        -w, -h;
         w, -h;
         w,  h;
        -w,  h
    ];
    R = [cos(angle), -sin(angle); sin(angle), cos(angle)];
    corners = (R * base')';
end
