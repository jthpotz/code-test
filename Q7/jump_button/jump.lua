jumpWindow = nil
jumpButton = nil

displayButton = nil

numMoves = 0 -- Used to make sure duplicate move events aren't running.
doMovement = false -- Used to make the button not move while the window is hidden.

jumpInterval = 30 -- Button position will be a multiple of jumpInterval, helps make jumps more noticable.
xSpawnOffset = 80 -- How far from the right to spawn the button.
xTeleportOffset = 20 -- How far from the left should the button teleport.
yMinOffset = 60 -- How far from the top of the window can the button appear.
yMaxOffset = 60 -- How far from the bottom of the window can the button appear.
buttonMoveDistance = 4 -- How far the button should move each time.
buttonMoveDelay = 50 -- How long between each time the button moves (in ms).

function init()

    -- This section is just to have a way to display the window.
    displayButton = modules.client_topmenu.addRightGameToggleButton('displayButton', tr('Jump'), '/images/topbuttons/hotkeys', toggle)
    displayButton:setOn(false)
    displayButton:show()
    -- =========

    jumpWindow = g_ui.displayUI('jump')
    jumpWindow:move(600, 200)
    jumpWindow:hide()

    jumpButton = jumpWindow:getChildById('jumpButton')
end

function terminate()
    jumpWindow:destroy()
    displayButton:destroy()
end

function toggle()
    if displayButton:isOn() then
        jumpWindow:hide()
        displayButton:setOn(false)
        doMovement = false -- Don't move if the window is hidden.
    else
        jumpWindow:show()
        displayButton:setOn(true)
        doMovement = true -- Only move if the window is shown.
        randomPosition()
    end
end

-- This function moves the button to a random position along the right side of the window.
function randomPosition()
    newPosition = jumpWindow:getPosition() -- Start with the window's top left position.
    newPosition.x = newPosition.x + jumpWindow:getWidth() - xSpawnOffset -- Add the window's width, but subtract an offset so the button isn't outside the window.
    height = math.random((yMinOffset / jumpInterval), (jumpWindow:getHeight() - yMaxOffset) / jumpInterval) * jumpInterval -- Pick a new random height. 
    newPosition.y = newPosition.y + height
    jumpButton:setPosition(newPosition)

    numMoves = numMoves + 1 -- Register that there is a move event scheduled. Prevents build up of numerous events.
    scheduleEvent(function() moveButton() end, buttonMoveDelay) -- Schedule event for the button to move.
end

function moveButton()

    numMoves = numMoves - 1 -- The event has fired.

    if not doMovement then
        return
    end

    buttonPosition = jumpButton:getPosition()
    buttonPosition.x = buttonPosition.x - buttonMoveDistance -- Move the button to the left.
    jumpButton:setPosition(buttonPosition)

    if jumpButton:getX() <= jumpWindow:getPosition().x + xTeleportOffset then -- If the button is near the left edge, then pick a new random position.
        randomPosition()
    elseif numMoves < 1 then -- Only schedule a new move event if there isn't already one.
        numMoves = numMoves + 1
        scheduleEvent(function() moveButton() end, buttonMoveDelay)
    end
end
