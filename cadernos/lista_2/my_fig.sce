fig = gcf()

fig.color_map = rainbowcolormap(4)
fig.anti_aliasing = "16x"

ax_d = fig.children(2)
ax_d.grid = [0,0]
ax_d.x_location = "origin"
ax_d.x_label.fill_mode = "on"
ax_d.x_label.auto_position = "off"
ax_d.x_label.position = [10.1, 0]
ax_d.y_label.text
ax_d.y_label.fill_mode = "on"
ax_d.y_label.text = "d"
ax_d.box = "on"

ax_d.children(1).thickness = 2.5


ax_x = fig.children(1)
ax_x.grid = [0,0]
ax_x.x_location = "origin"
ax_x.x_label.fill_mode = "on"
ax_x.x_label.auto_position = "off"
ax_x.x_label.position = [10.1, 0]
ax_x.y_label.text
ax_x.y_label.fill_mode = "on"
ax_x.y_label.text = "x"
ax_x.box = "on"

for i=1:3
    ax_x.children(i).thickness = 2.5
end
