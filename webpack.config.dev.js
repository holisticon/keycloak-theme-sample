const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyPlugin = require('copy-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const Dotenv = require('dotenv-webpack');
const HtmlWebpackInlineSourcePlugin = require('html-webpack-inline-source-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

const outputFolder = 'dist/holisticon';

const commonConfig = (entryPoint) => {
    let config = {
        entry: `./src/templates/${entryPoint}/index.ts`,

        module: {
            rules: [
                {
                    include: [path.resolve(__dirname, 'src/templates')],
                    test: /\.tsx?$/,
                    use: 'ts-loader',
                    exclude: /node_modules/
                },
                {
                    include: [path.resolve(__dirname, 'src/templates')],
                    loader: 'babel-loader',

                    options: {
                        plugins: [
                            'syntax-dynamic-import',
                        ],

                        presets: [
                            [
                                '@babel/preset-env',
                                {
                                    modules: false
                                }
                            ]
                        ]
                    },

                    test: /\.js$/
                },
                {
                    test: /\.ftl$/,
                    loader: "html-loader"
                },
                {
                    test: /\.(scss|css)$/,

                    use: [

                        {
                            loader: MiniCssExtractPlugin.loader,
                            options: {
                                // you can specify a publicPath here
                                // by default it uses publicPath in webpackOptions.output
                                publicPath: '../',
                                hmr: process.env.NODE_ENV === 'development',
                            },
                        },
                        {
                            loader: 'css-loader',
                            options: {
                                url: false
                            }
                        },
                        {
                            loader: 'resolve-url-loader'
                        },
                        {
                            loader: 'sass-loader',
                            options: {
                                "includePaths": [
                                    require('path').resolve(__dirname, 'node_modules'),
                                    require('path').resolve(__dirname, 'src/fonts'),
                                    require('path').resolve(__dirname, 'src/images'),
                                    require('path').resolve(__dirname, 'node_modules/patternfly/dist/sass'),
                                    require('path').resolve(__dirname, 'node_modules/bootstrap-sass/assets/stylesheets'),
                                    require('path').resolve(__dirname, 'node_modules/font-awesome-sass/assets/stylesheets'),
                                ]
                            },
                        }
                    ]
                }
            ]
        },

        output: {
            filename: 'bundle.js',
            path: path.join(__dirname, `./${outputFolder}/${entryPoint}/resources/js/`),
            publicPath: '${url.resourcesPath}/js/'
        },

        mode: process.env.NODE_ENV || 'development',

        plugins: [
            new CleanWebpackPlugin(),
            new webpack.BannerPlugin({
                banner: () => `Copyright ${new Date().getFullYear()}`
            }),

            new webpack.EnvironmentPlugin({}),
            new Dotenv(),
            new CopyPlugin([
                {
                    from: path.join(__dirname, `src/fonts`),
                    to: path.join(__dirname, `${outputFolder}/${entryPoint}/resources/fonts`),
                },
                {
                    from: path.join(__dirname, `node_modules/patternfly/dist/fonts`),
                    to: path.join(__dirname, `${outputFolder}/${entryPoint}/resources/fonts`),
                },
                {
                    from: path.join(__dirname, `src/images`),
                    to: path.join(__dirname, `${outputFolder}/${entryPoint}/resources/images`),
                },
                {
                    from: path.join(__dirname, `src/templates/${entryPoint}`),
                    to: path.join(__dirname, `${outputFolder}/${entryPoint}`),
                    ignore: ['*.js', '*.ts', '*.scss'],
                },
            ]),
        ],

        optimization: {
            splitChunks: {
                cacheGroups: {
                    vendors: {
                        priority: -10,
                        test: /[\\/]node_modules[\\/]/
                    }
                },

                chunks: 'async',
                minChunks: 1,
                minSize: 30000,
                name: true,
            },
            minimizer: [],
        },
    }
    if (entryPoint != 'email') {
        config.plugins.push(new HtmlWebpackPlugin({
            filename: `../../template.ftl`,
            template: `./src/templates/${entryPoint}/template.ftl`,
            inject: true,
            inlineSource: '.(css)$' // embed all css inline
        }));
        config.plugins.push(new MiniCssExtractPlugin({
            // Options similar to the same options in webpackOptions.output
            // all options are optional
            filename: '[name].css',
            chunkFilename: '[id].css',
            ignoreOrder: false, // Enable to remove warnings about conflicting order
        }));
        config.plugins.push(new HtmlWebpackInlineSourcePlugin());
    }
    return config;
};

module.exports = ['login', 'account', 'email'].map(res => commonConfig(res));
