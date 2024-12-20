import { Router } from 'express'
import UsersController from './Users'
import FileController from './File'
import ConfigController from './Config'
import CommonController from './Common'
import YonghuController from './Yonghu'
import KefangxinxiController from './Kefangxinxi'
import DingfangxinxiController from './Dingfangxinxi'
import XufangxinxiController from './Xufangxinxi'
import HuanfangxinxiController from './Huanfangxinxi'
import TuifangxinxiController from './Tuifangxinxi'
import FeiyongxinxiController from './Feiyongxinxi'

export default ({ config, db }) => {
	let api = Router()

	api.use('/users', UsersController({ config, db }))

	api.use('/file', FileController({ config, db }))

	api.use('/config', ConfigController({ config, db }))

	api.use('/', CommonController({ config, db }))

	api.use('/yonghu', YonghuController({ config, db }))

	api.use('/kefangxinxi', KefangxinxiController({ config, db }))

	api.use('/dingfangxinxi', DingfangxinxiController({ config, db }))

	api.use('/xufangxinxi', XufangxinxiController({ config, db }))

	api.use('/huanfangxinxi', HuanfangxinxiController({ config, db }))

	api.use('/tuifangxinxi', TuifangxinxiController({ config, db }))

	api.use('/feiyongxinxi', FeiyongxinxiController({ config, db }))

	return api
}
