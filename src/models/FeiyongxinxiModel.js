import { Sequelize, DataTypes } from 'sequelize'
import moment from 'moment'
import sequelize from './sequelize'

// 费用信息
const FeiyongxinxiModel = sequelize.define('FeiyongxinxiModel', {
	id: {
		type: DataTypes.BIGINT,
		primaryKey: true,
		autoIncrement: true,
		allowNull: false,
		comment: '主键id'
	},
	feiyongbianhao: {
		type: DataTypes.STRING,
		defaultValue: '',
		allowNull: true,
		comment: '费用编号'
	},
	kefangbianhao: {
		type: DataTypes.STRING,
		defaultValue: '',
		allowNull: true,
		comment: '客房编号'
	},
	kefangleixing: {
		type: DataTypes.STRING,
		defaultValue: '',
		allowNull: true,
		comment: '客房类型'
	},
	feiyongjine: {
		type: DataTypes.FLOAT,
		defaultValue: 0,
		allowNull: true,
		comment: '费用金额'
	},
	feiyongmiaoshu: {
		type: DataTypes.TEXT,
		defaultValue: '',
		allowNull: true,
		comment: '费用描述'
	},
	zhanghao: {
		type: DataTypes.STRING,
		defaultValue: '',
		allowNull: true,
		comment: '账号'
	},
	xingming: {
		type: DataTypes.STRING,
		defaultValue: '',
		allowNull: true,
		comment: '姓名'
	},
	ispay: {
		type: DataTypes.STRING,
		defaultValue: '',
		allowNull: true,
		comment: '是否支付'
	},
	addtime: {
  		type: DataTypes.DATE,
  		defaultValue: DataTypes.NOW,
    	allowNull: false,
    	get() {
            return moment(this.getDataValue('addtime')).format('YYYY-MM-DD HH:mm:ss')
        },
		comment: '添加时间'
	}
}, {
	timestamps: false,
	freezeTableName: true,
	tableName: 'feiyongxinxi'
})

export default FeiyongxinxiModel
