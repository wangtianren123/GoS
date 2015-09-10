require('math')

local index_table = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'


function to_binary(integer)
    local remaining = tonumber(integer)
    local bin_bits = ''

    for i = 7, 0, -1 do
        local current_power = math.pow(2, i)

        if remaining >= current_power then
            bin_bits = bin_bits .. '1'
            remaining = remaining - current_power
        else
            bin_bits = bin_bits .. '0'
        end
    end

    return bin_bits
end

function from_binary(bin_bits)
    return tonumber(bin_bits, 2)
end

function SSLDecode(to_decode)
    local padded = to_decode:gsub("%s", "")
    local unpadded = padded:gsub("=", "")
    local bit_pattern = ''
    local decoded = ''

    for i = 1, string.len(unpadded) do
        local char = string.sub(to_decode, i, i)
        local offset, _ = string.find(index_table, char)
        if offset == nil then
             error("Invalid character '" .. char .. "' found.")
        end

        bit_pattern = bit_pattern .. string.sub(to_binary(offset-1), 3)
    end

    for i = 1, string.len(bit_pattern), 8 do
        local byte = string.sub(bit_pattern, i, i+7)
        decoded = decoded .. string.char(from_binary(byte))
    end

    local padding_length = padded:len()-unpadded:len()

    if (padding_length == 1 or padding_length == 2) then
        decoded = decoded:sub(1,-2)
    end
    return decoded
end
assert(loadstring(SSLDecode("bG9jYWwgZW5lbXlCYXNlUG9zLCBkZWxheSwgbWlzc2lsZVNwZWVkLCBkYW1hZ2UsIHJlY2FsbFBvcyA9IG5pbCwgMCwgMCwgbmlsLCBuaWwKQmFzZXVsdE1lbnUgPSBNZW51KCJCYXNldWx0IiwgIkJhc2V1bHQiKQpCYXNldWx0TWVudTpCb29sZWFuKCJFbmFibGVkIiwgIkVuYWJsZWQiLCB0cnVlKQpteUhlcm8gPSBHZXRNeUhlcm8oKQptYXBJRCA9IEdldE1hcElEKCkKCmlmIG1hcElEID09IFNVTU1PTkVSU19SSUZUIGFuZCBHZXRUZWFtKG15SGVybykgPT0gMTAwIHRoZW4KZW5lbXlCYXNlUG9zID0gVmVjdG9yKDE0MzQwLCAxNzEsIDE0MzkwKQplbHNlaWYgbWFwSUQgPT0gU1VNTU9ORVJTX1JJRlQgYW5kIEdldFRlYW0obXlIZXJvKSA9PSAyMDAgdGhlbiAKZW5lbXlCYXNlUG9zID0gVmVjdG9yKDQwMCwgMjAwLCA0MDApCmVuZAoKaWYgbWFwSUQgPT0gQ1JZU1RBTF9TQ0FSIGFuZCBHZXRUZWFtKG15SGVybykgPT0gMTAwIHRoZW4KZW5lbXlCYXNlUG9zID0gVmVjdG9yKDEzMzIxLCAtMzcsIDQxNjMpCmVsc2VpZiBtYXBJRCA9PSBDUllTVEFMX1NDQVIgYW5kIEdldFRlYW0obXlIZXJvKSA9PSAyMDAgdGhlbiAKZW5lbXlCYXNlUG9zID0gVmVjdG9yKDUyNywgLTM1LCA0MTYzKQplbmQKCmlmIG1hcElEID09IFRXSVNURURfVFJFRUxJTkUgYW5kIEdldFRlYW0obXlIZXJvKSA9PSAxMDAgdGhlbgplbmVteUJhc2VQb3MgPSBWZWN0b3IoMTQzMjAsIDE1MSwgNzIzNSkKZWxzZWlmIG1hcElEID09IFRXSVNURURfVFJFRUxJTkUgYW5kIEdldFRlYW0obXlIZXJvKSA9PSAyMDAgdGhlbiAKZW5lbXlCYXNlUG9zID0gVmVjdG9yKDEwNjAsIDE1MCwgNzI5NykKZW5kCgppZiBHZXRPYmplY3ROYW1lKG15SGVybykgPT0gIkFzaGUiIHRoZW4KCWRlbGF5ID0gMjUwCgltaXNzaWxlU3BlZWQgPSAxNjAwCglkYW1hZ2UgPSBmdW5jdGlvbih0YXJnZXQpIHJldHVybiBDYWxjRGFtYWdlKG15SGVybywgdGFyZ2V0LCAwLCA3NSArIDE3NSpHZXRDYXN0TGV2ZWwobXlIZXJvLF9SKSArIEdldEJvbnVzQVAobXlIZXJvKSkgZW5kCmVsc2VpZiBHZXRPYmplY3ROYW1lKG15SGVybykgPT0gIkRyYXZlbiIgdGhlbgoJZGVsYXkgPSA0MDAKCW1pc3NpbGVTcGVlZCA9IDIwMDAKCWRhbWFnZSA9IGZ1bmN0aW9uKHRhcmdldCkgcmV0dXJuIENhbGNEYW1hZ2UobXlIZXJvLCB0YXJnZXQsIDc1ICsgMTAwKkdldENhc3RMZXZlbChteUhlcm8sX1IpICsgMS4xKkdldEJvbnVzRG1nKG15SGVybykpIGVuZAplbHNlaWYgR2V0T2JqZWN0TmFtZShteUhlcm8pID09ICJFenJlYWwiIHRoZW4KCWRlbGF5ID0gMTAwMAoJbWlzc2lsZVNwZWVkID0gMjAwMAoJZGFtYWdlID0gZnVuY3Rpb24odGFyZ2V0KSByZXR1cm4gQ2FsY0RhbWFnZShteUhlcm8sIHRhcmdldCwgMCwgMjAwICsgMTUwKkdldENhc3RMZXZlbChteUhlcm8sX1IpICsgLjkqR2V0Qm9udXNBUChteUhlcm8pK0dldEJvbnVzRG1nKG15SGVybykpIGVuZAplbHNlaWYgR2V0T2JqZWN0TmFtZShteUhlcm8pID09ICJKaW54IiB0aGVuCglkZWxheSA9IDYwMAogICAgbWlzc2lsZVNwZWVkID0gKEdldERpc3RhbmNlKGVuZW15QmFzZVBvcykgLyAoMSArIChHZXREaXN0YW5jZShlbmVteUJhc2VQb3MpLTE1MDApLzI1MDApKSAtLSB0aGFua3MgTm9kZHkKCWRhbWFnZSA9IGZ1bmN0aW9uKHRhcmdldCkgcmV0dXJuIENhbGNEYW1hZ2UobXlIZXJvLCB0YXJnZXQsIChHZXRNYXhIUCh0YXJnZXQpLUdldEN1cnJlbnRIUCh0YXJnZXQpKSooMC4yKzAuMDUqR2V0Q2FzdExldmVsKG15SGVybywgX1IpKSArIDE1MCArIDEwMCpHZXRDYXN0TGV2ZWwobXlIZXJvLF9SKSArIEdldEJvbnVzRG1nKG15SGVybykpIGVuZAplbmQKCk9uUHJvY2Vzc1JlY2FsbChmdW5jdGlvbihPYmplY3QscmVjYWxsUHJvYykKCWlmIENhblVzZVNwZWxsKG15SGVybywgX1IpID09IFJFQURZIGFuZCBCYXNldWx0TWVudS5FbmFibGVkOlZhbHVlKCkgYW5kIEdldFRlYW0oT2JqZWN0KSB+PSBHZXRUZWFtKG15SGVybykgdGhlbgoJCWlmIGRhbWFnZShPYmplY3QpID4gR2V0Q3VycmVudEhQKE9iamVjdCkgdGhlbgoJCQlsb2NhbCB0aW1lVG9SZWNhbGwgPSByZWNhbGxQcm9jLnRvdGFsVGltZQoJCQlsb2NhbCBkaXN0YW5jZSA9IEdldERpc3RhbmNlKGVuZW15QmFzZVBvcykKCQkJbG9jYWwgdGltZVRvSGl0ID0gZGVsYXkgKyAoZGlzdGFuY2UgKiAxMDAwIC8gbWlzc2lsZVNwZWVkKQoJCQlpZiB0aW1lVG9SZWNhbGwgPiB0aW1lVG9IaXQgdGhlbgoJCQkJcmVjYWxsUG9zID0gVmVjdG9yKE9iamVjdCkKCQkJCVByaW50Q2hhdCgiQmFzZVVsdCBvbiAiLi5HZXRPYmplY3ROYW1lKE9iamVjdCksIDIsIDB4ZmZmZjAwMDApCgkJCQlEZWxheUFjdGlvbigKCQkJICAgICAgIAlmdW5jdGlvbigpIAoJCQkJCQlpZiByZWNhbGxQb3MgPT0gVmVjdG9yKE9iamVjdCkgdGhlbgoJCQkJCQkJQ2FzdFNraWxsU2hvdChfUiwgZW5lbXlCYXNlUG9zLngsIGVuZW15QmFzZVBvcy55LCBlbmVteUJhc2VQb3MueikKCQkJCQkJCXJlY2FsbFBvcyA9IG5pbAoJCQkJCQllbmQKCQkJCQllbmQsIAoJCQkJCXRpbWVUb1JlY2FsbC10aW1lVG9IaXQKCQkJCSkKCQkJZW5kCgkJZW5kCgllbmQKZW5kKQ=="), nil, "bt", _ENV))()
