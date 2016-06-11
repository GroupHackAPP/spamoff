local function history(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, '"'..#result..'" پیام اخیر سوپر گروه حذف شد', ok_cb, false)
  else
    send_msg(extra.chatid, '📢 پیام های مورد نظر شما پاک شدند', ok_cb, false)
  end
end
local function run(msg, matches)
  if matches[1] == 'rmsg' and is_owner(msg) then
    if msg.to.type == 'channel' then
      if tonumber(matches[2]) > 10000 or tonumber(matches[2]) < 1 then
        return "🔢 تعداد بیشتر از 1 مجاز است"
      end
      get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
    else
      return "ℹ️ این امکان تنها در سوپر گروه فعال استت"
    end
  else
    return "ℹ️ شما به این بخش دسترسی نداریدد"
  end
end

return {
    patterns = {
        '^[!/#](del) (%d*)$'
    },
    run = run
}
