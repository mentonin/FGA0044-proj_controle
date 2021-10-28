function c = hex2rgb(hex)
    hex = strsubst(hex, '#', '');
    dec = hex2dec(hex);
    r = int(dec / (256*256));
    g = int(modulo(dec, 256*256) / 256);
    b = modulo(dec, 256);
    c = [r, g, b] / 255;
endfunction


fig = gcf();

t_lim = 5;

matplotlib_colors = ['#1f77b4';
                     '#ff7f0e';
                     '#2ca02c';
                     '#d62728';
                     '#9467bd';
                     '#8c564b';
                     '#e377c2';
                     '#7f7f7f';
                     '#bcbd22';
                     '#17becf'];

fig.color_map = hex2rgb(matplotlib_colors);
fig.anti_aliasing = "16x";


n_d = 1;
ax_d = fig.children(4);
ax_d.grid = [0,0];
ax_d.x_location = "origin";
ax_d.x_label.fill_mode = "on";
ax_d.x_label.auto_position = "off";
ax_d.x_label.position = [t_lim * 1.01, 0];
ax_d.y_label.fill_mode = "on";
ax_d.y_label.text = "d";
ax_d.box = "on";

for i=1:n_d
    ax_d.children(i).thickness = 2.5;
    ax_d.children(i).foreground = i;
end


n_x = 3;
ax_x = fig.children(3);
ax_x.grid = [0,0];
ax_x.x_location = "origin";
ax_x.x_label.fill_mode = "on";
ax_x.x_label.auto_position = "off";
ax_x.x_label.position = [t_lim * 1.01, 0];
ax_x.y_label.fill_mode = "on";
ax_x.y_label.text = "x";
ax_x.box = "on";

for i=1:n_x
    ax_x.children(i).thickness = 2.5;
    ax_x.children(i+n_x).thickness = 2.5;
    ax_x.children(i).line_style = 1;
    ax_x.children(i+n_x).line_style = 3;
    ax_x.children(i).foreground = i+n_d;
    ax_x.children(i+n_x).foreground = ax_x.children(i).foreground;
end


n_y = 1;
ax_y = fig.children(2);
ax_y.grid = [0,0];
ax_y.x_location = "origin";
ax_y.x_label.fill_mode = "on";
ax_y.x_label.auto_position = "off";
ax_y.x_label.position = [t_lim * 1.01, 0];
ax_y.y_label.fill_mode = "on";
ax_y.y_label.text = "y, y_";
ax_y.box = "on";

for i=1:n_y
    ax_y.children(i).thickness = 2.5;
    ax_y.children(i+n_y).thickness = 2.5;
    ax_y.children(i).line_style = 1;
    ax_y.children(i+n_y).line_style = 3;
    ax_y.children(i).foreground = i+n_d+n_x;
    ax_y.children(i+n_y).foreground = ax_y.children(i).foreground;
end


n_e = 1;
ax_e = fig.children(1);
ax_e.grid = [0,0];
ax_e.x_location = "origin";
ax_e.x_label.fill_mode = "on";
ax_e.x_label.auto_position = "off";
ax_e.x_label.position = [t_lim * 1.01, 0];
ax_e.y_label.fill_mode = "on";
ax_e.y_label.text = "y - y_";
ax_e.box = "on";
for i=1:n_e
    ax_e.children(i).thickness = 2.5;
    ax_e.children(i).line_style = 1;
    ax_e.children(i).foreground = i+n_d+n_x+n_y;
end
