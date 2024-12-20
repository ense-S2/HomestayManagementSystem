import http from 'http'
import path from 'path'
import express from 'express'
import cors from 'cors'			//CORS处理跨域请求
import morgan from 'morgan'
import bodyParser from 'body-parser'
import expressSession from 'express-session'
import expressJWT from 'express-jwt'
import initializeDb from './db'
import middleware from './middleware'
import api from './api'
import config from './config.json'
import util from './lib/util'

let app = express()
app.server = http.createServer(app)

// app.use(morgan('dev'))

//允许前端跨域访问
app.use(cors({
	exposedHeaders: config.corsHeaders
}))

//解析请求体的json格式，默认限制请求体大小，防止恶意请求
app.use(bodyParser.json({
	limit : config.bodyLimit
}))

//session管理
app.use(expressSession({
	secret: config.sessionSecret,	//session密钥
	resave: false,					//不强制保存未修改的session
	saveUninitialized: true			//保存未初始化的session
}))

//静态资源（html、css、js）存放在views文件夹中
app.use('/' + config.projectName, express.static(path.join(__dirname, 'views')))

//对请求进行鉴权，请求是否携带有效的token
app.use(expressJWT({
	secret: config.jwtSecret,	//密钥用于验证token是否有效
	algorithms: ["HS256"],
	credentialsRequired: true,
	getToken (req) {	//从请求头获取token
		
		return util.isNothing(req.headers.token) ? null : req.headers.token
	},
	requestProperty: 'xiezn'	//JWT解析后的token数据存储在req.xiezn
}).unless({		//鉴权白名单
	path: [
		{
			url: /.*\/(login|register|upload|download|resetPass|autoSort|list|sendemail|notify)$/,
			methods: ['GET', 'POST']
		},
		{
			url: /.*\/(config|option|follow|sh|remind|cal|group|value|news|info|detail|forum)\/.*/,
			methods: ['GET', 'POST']
		}
	]
}))

//鉴权失败错误处理
app.use((err, req, res, next) => {

	if (err.name === 'UnauthorizedError') {
		res.status(200).json({
			code: 401,
			msg: '您的权限不够！'
		})
	}
})

//初始化加载数据库、中间件、api
initializeDb( db => {
	//中间件传入数据库
	app.use(middleware({ config, db }))
	//api路由传入数据库
	app.use('/' + config.projectName, api({ config, db }))
	//启动http服务器，监听端口
	app.server.listen(process.env.PORT || config.port, () => {
		console.log(`Started on port ${app.server.address().port}`)
	})
})

export default app
