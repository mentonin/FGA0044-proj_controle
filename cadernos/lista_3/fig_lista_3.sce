fig = gcf()

t_lim = 5

fig.color_map = [rainbowcolormap(4); rainbowcolormap(3)]
fig.anti_aliasing = "16x"

ax_d = fig.children(4)
ax_d.grid = [0,0]
ax_d.x_location = "origin"
ax_d.x_label.fill_mode = "on"
ax_d.x_label.auto_position = "off"
ax_d.x_label.position = [t_lim * 1.01, 0]
ax_d.y_label.fill_mode = "on"
ax_d.y_label.text = "d"
ax_d.box = "on"

ax_d.children(1).thickness = 2.5


ax_x = fig.children(3)
ax_x.grid = [0,0]
ax_x.x_location = "origin"
ax_x.x_label.fill_mode = "on"
ax_x.x_label.auto_position = "off"
ax_x.x_label.position = [t_lim * 1.01, 0]
ax_x.y_label.fill_mode = "on"
ax_x.y_label.text = "x"
ax_x.box = "on"

for i=1:3
    ax_x.children(i).thickness = 2.5
end


ax_y = fig.children(2)
ax_y.grid = [0,0]
ax_y.x_location = "origin"
ax_y.x_label.fill_mode = "on"
ax_y.x_label.auto_position = "off"
ax_y.x_label.position = [t_lim * 1.01, 0]
ax_y.y_label.fill_mode = "on"
ax_y.y_label.text = "y, y_"
ax_y.box = "on"

for i=1:2
    ax_y.children(i).thickness = 2.5
end


ax_e = fig.children(1)
ax_e.grid = [0,0]
ax_e.x_location = "origin"
ax_e.x_label.fill_mode = "on"
ax_e.x_label.auto_position = "off"
ax_e.x_label.position = [t_lim * 1.01, 0]
ax_e.y_label.fill_mode = "on"
ax_e.y_label.text = "y - y_"
ax_e.box = "on"

ax_e.children(1).thickness = 2.5
