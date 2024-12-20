import { Sequelize } from 'sequelize'
import config from '../config.json'

const sequelize = new Sequelize(config.dbConnection.database, config.dbConnection.username, config.dbConnection.password, {
	host: 'localhost',
	dialect: config.dbConnection.dbtype,	//数据库类型
	logging: false		//关闭SQL查询日志
})

export default sequelize