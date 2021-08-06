import json, httpclient

proc qywxsend(message: string): string =
    var client = newHttpClient()

    let corp_id = "" #Your corp_id
    let app_secret = "" #Your app_secret
    let app_id = "" #Your app_id

    let qxgeturl = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid="&corp_id&"&corpsecret="&app_secret

    let qxgetjson = client.getContent(qxgeturl)

    let parsedObject = parseJson(qxgetjson)

    let qywx_access_token = parsedObject["access_token"].getStr()

    let qxposturl = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token="&qywx_access_token

    let touser = "@all"
    let msgtype = "text"
    let safe = 0
    let agentid = app_id

    let client2 = newHttpClient()
    client2.headers = newHttpHeaders({ "Content-Type": "application/json" })

    var innerObject = %* {"content": message}
    var jsonObject = %* {"touser": touser, "msgtype": msgtype, "text": innerObject, "safe": safe, "agentid": agentid }

    let response = client.request(qxposturl, httpMethod = HttpPost, body = $jsonObject)
    var rtnresult = "Message:"&message&" sent. \n"&response.body
    return rtnresult

var message = "😆✌🤷‍♂️"
echo qywxsend(message)