x = 400
print(love.system.getPowerInfo())

local COLOR_MUL = love._version >= "11.0" and 1 or 255

print(COLOR_MUL)

snake = {{10, 4}}

len = 1

size = 20

move = 'r'

timer = 0

rnd = love.math.newRandomGenerator()

sx = 27
sy = 27

mousex = -100
mousey = -100

joystickx = 200


if not (love.system.getOS() == "Android") then
    love.window.setMode(27 * size, 27 * size)
    
else
    sx = 800 / size - (joystickx / size)
    sy = 380 / size
end

applex = 1
appley = 1
math.randomseed(os.time())

RandomGenerator = love.math.newRandomGenerator( )

function new_apple()
    _G.applex = math.random(1, sx - 2)
    _G.appley = math.random(1, sy - 2)
    for i, j in ipairs(snake) do
        if applex == j[1] and appley == j[2] then
            new_apple()
        end
    end
end

new_apple()

buttonlx = sx * size + 55
mxscore = 0


function generate_gradient()
    local verts = {}
    table.insert(verts, {0, 0, 1, 1, 0, 1, 0})
    table.insert(verts, {0, 1, 1, 1, 0, 0, 0.3})
    table.insert(verts, {1, 1, 1, 1, 0, 0, 0.3})
    table.insert(verts, {1, 0, 1, 1, 0, 1, 0})


    return love.graphics.newMesh(verts, "fan")
end

bg = generate_gradient()

function love.load()
    game = 0
    len = 1
    snake = {{10, 4}}
    move = 'r'
    move_changed = 0
end

function love.draw()
    if game == 1 then
        love.graphics.setColor(0, 0.4, 1)
        if love.system.getOS() == "Android" then
            love.graphics.draw(bg, 0, 25, 0, sx * size, sy * size)
            -- walls
            love.graphics.rectangle("fill", 0, 25, sx * size, size)
            love.graphics.rectangle("fill", 0, (sy) * size + 25 - size, sx * size, size)
            love.graphics.rectangle("fill", 0, 25, size, sy * size)
            love.graphics.rectangle("fill", (sx) * size - size, 25, size, sy * size)
            -- apple
            love.graphics.setColor(0.7, 0, 0.5)
            love.graphics.rectangle("fill", applex * size, appley * size + 25, size, size)
            love.graphics.setColor(1, 1, 1)
            love.graphics.circle("fill", buttonlx, 180, 25)
            love.graphics.rectangle("fill", buttonlx, 180, 1, 1)
            love.graphics.circle("fill", buttonlx + 40, 140, 25)

            love.graphics.circle("fill", buttonlx + 80, 200, 25)
            love.graphics.circle("fill", buttonlx + 40, 240, 25)
            love.graphics.setColor(0, 0, 0)
            --love.graphics.triangle("fill", buttonlx - 20, 180, buttonlx + 5, 170, buttonlx + 5, 190)
            --love.graphics.triangle("fill", buttonlx + 45, 140, buttonlx + 45, 130, buttonlx + 40, 160)
            --love.graphics.triangle("fill", buttonlx + 85, 200, buttonlx + 85, 190, buttonlx + 80, 220)
            --love.graphics.triangle("fill", buttonlx + 45, 240, buttonlx + 45, 230, buttonlx + 40, 260)

            love.graphics.setColor(0, 1, 0.5)
            for i=1, len do
                if snake[i][1] == snake[1][1] and snake[i][2] == snake[1][2] and not (i == 1) then
                    die()
                end
                love.graphics.rectangle("fill", snake[i][1] * size, 25 + snake[i][2] * size, size, size)
            end
            love.graphics.setColor(1, 1, 1)


            love.graphics.print(love.timer.getFPS(), 0, 25)
            love.graphics.print(len, 50, 0)

        else
            love.graphics.draw(bg, 0, 0, 0, sx * size, sy * size)
            love.graphics.rectangle("fill", 0, 0, sy * size, size)
            love.graphics.rectangle("fill", 0, (sx - 1) * size, sy * size, size)
            love.graphics.rectangle("fill", 0, 0, size, sy * size)
            love.graphics.rectangle("fill", (sx - 1) * size, 0, size, sx * size)
            love.graphics.setColor(0.7, 0, 0.5)
            love.graphics.rectangle("fill", applex * size, appley * size, size, size)

            --love.graphics.print(love.system.getOS(), x, 300)
            love.graphics.setColor(0, 1, 0.5)
            for i=1, len do
                if snake[i][1] == snake[1][1] and snake[i][2] == snake[1][2] and not (i == 1) then
                    die()
                    do return end
                end
                love.graphics.rectangle("fill", snake[i][1] * size, snake[i][2] * size, size, size)
            end
            love.graphics.setColor(1, 1, 1)
            love.graphics.print(love.timer.getFPS(), 0, 0)
            love.graphics.print(len, 50, 0)
        end
    else
        love.graphics.setColor(1, 1, 1)
        if love.system.getOS() == "Android" then
            love.graphics.print("Touch screen to start...", 10, 60)
        else
            love.graphics.print("Press key to start...", 10, 10)
        end
        love.graphics.print("Best score for the session is - ", 10, 100)
        love.graphics.print(mxscore, 10, 140)

    end



    --love.timer.sleep(sleeping)

end


function love.touchpressed(id, x, y, dx, dy, pressure)
    if game == 0 then
        game = 1
        
    end
    mousex = x
    mousey = y
    if move_changed == 1 then
        do return end
    end
    if (math.sqrt((mousex - buttonlx) * (mousex - buttonlx) + (mousey - 180) * (mousey - 180)) <= 25 and not (move == 'r')) then
        move = 'l'
        move_changed = 1
    end
    if (math.sqrt((mousex - buttonlx - 40) * (mousex - buttonlx - 40) + (mousey - 140) * (mousey - 140)) <= 25 and not (move == 'd')) then
        move = 'u'
        move_changed = 1
    end
    if (math.sqrt((mousex - buttonlx - 80) * (mousex - buttonlx - 80) + (mousey - 200) * (mousey - 200)) <= 25 and not (move == 'l')) then
        move = 'r'
        move_changed = 1
    end
    if (math.sqrt((mousex - buttonlx - 40) * (mousex - buttonlx - 40) + (mousey - 240) * (mousey - 240)) <= 25 and not (move == 'u')) then
        move = 'd'
        move_changed = 1
    end
end

function love.keypressed(key, code, isrepeat)
    if game == 0 then 
        game = 1 
    end
    if move_changed == 1 then
        do return end
    end
    if (key == 'a' or key == 'left') and not (move == 'r') then
        move = 'l'
        move_changed = 1
    end
    if (key == 'd' or key == 'right') and not (move == 'l') then
        move = 'r'
        move_changed = 1
    end
    if (key == 'w' or key == 'up') and not (move == 'd') then
        move = 'u'
        move_changed = 1
    end
    if (key == 's' or key == 'down') and not (move == 'u') then
        move = 'd'
        move_changed = 1
    end
end

function die()
    if len > mxscore then
        mxscore = len
    end
    love.load()
end

function love.update(dt)

    if (snake[1][1] == applex and snake[1][2] == appley) then
        table.insert(snake, len + 1, {-10, -10})
        len = len + 1
        new_apple()
    end

    if snake[1][1] < 1 or snake[1][2] < 1 or snake[1][1] > sx - 2 or snake[1][2] > sy - 2 then
        die()
    end

    
    if timer % 10 == 0 then
        move_changed = 0
        timer = 1
        if len > 1 then
            for i=len, 2, -1 do
                snake[i][1] = snake[i - 1][1]
                snake[i][2] = snake[i - 1][2]
            end
        end

        if move == 'l' then
            snake[1][1] = snake[1][1] - 1
        end
        if move == 'r' then
            snake[1][1] = snake[1][1] + 1
        end
        if move == 'u' then
            snake[1][2] = snake[1][2] - 1
        end
        if move == 'd' then
            snake[1][2] = snake[1][2] + 1
        end

    end
    timer = timer + 1




end



